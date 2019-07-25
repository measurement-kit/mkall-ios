// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKAsyncTask.h"

#import "measurement_kit/internal/vendor/json.hpp"
#import "measurement_kit/ffi.h"

#import "MKResources.h"

@interface MKAsyncTask ()

@property mk_task_t *task;

@end  // interface MKAsyncTask

// Serialize settings to JSON.
static NSString *marshal_settings(NSDictionary *settings) {
  NSError *error = nil;
  NSData *data = [NSJSONSerialization dataWithJSONObject:settings
                  options:0 error:&error];
  if (error != nil) return nil;
  // Using initWithData because data is not terminated by zero.
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// updates settings adding resources and then starts the nettest task.
static mk_task_t *updateSettingsAndStart(const char *settings) {
  nlohmann::json doc;
  try {
    doc = nlohmann::json::parse(settings);
  } catch (const std::exception &exc) {
    NSLog(@"MKAsyncTask: cannot parse settings: %s", exc.what());
    return nullptr;
  }
  nlohmann::json &o = doc["options"];
  o["net/ca_bundle_path"] = [[MKResources caBundlePath] UTF8String];
  o["geoip_asn_path"] = [[MKResources mmdbASNPath] UTF8String];
  o["geoip_country_path"] = [[MKResources mmdbCountryPath] UTF8String];
  std::string reserio;
  try {
    reserio = doc.dump();
  } catch (const std::exception &exc) {
    NSLog(@"MKAsyncTask: cannot reserialize settings: %s", exc.what());
    return nullptr;
  }
  NSLog(@"MKAsyncTask: settings passed to MK: %s", reserio.c_str());
  return mk_task_start(reserio.c_str());
}

@implementation MKAsyncTask

+ (MKAsyncTask *)start:(NSDictionary *)settings {
  NSString *str = marshal_settings(settings);
  if (str == nil) return nil;
  MKAsyncTask *task = [MKAsyncTask alloc];
  if (task == nil) return nil;
  task.task = updateSettingsAndStart([str UTF8String]);
  return (task.task != nil) ? task : nil;
}

- (BOOL)done {
  return mk_task_is_done(self.task) ? TRUE : FALSE;
}

- (NSDictionary *)waitForNextEvent {
  // In this function we abort() a lot because most error conditions
  // correspond to very bad conditions that should not happen.
  mk_event_t *evp = mk_task_wait_for_next_event(self.task);
  if (evp == NULL) abort();
  const char *s = mk_event_serialize(evp);
  if (s == NULL) abort();
  // Here it's important to specify freeWhenDone because we control
  // the lifecycle of the data object using `eventp`.
  NSData *data = [NSData dataWithBytesNoCopy:(void *)s length:strlen(s)
                  freeWhenDone:NO];
  if (data == nil) abort();
  NSError *error = nil;
  NSDictionary *evinfo = [NSJSONSerialization JSONObjectWithData:data
                          options:0 error:&error];
  if (error != nil) {
    NSLog(@"Failed to parse event: %@", error);
    abort();
  }
  mk_event_destroy(evp);
  return evinfo;
}

- (void)interrupt {
  mk_task_interrupt(self.task);
}

- (void)dealloc {
  mk_task_destroy(self.task);
}

@end  // implementation MKAsyncTask

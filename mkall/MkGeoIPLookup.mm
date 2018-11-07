// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

// Note: this file is Objective-C++ because otherwise the whole project
// will compile as Objective-C and link will fail mentioning that several
// C++ related symbols are missing (of course).

#import "MkGeoIPLookup.h"
#import "MkResources.h"

#import <measurement_kit/vendor/mkgeoip.h>

@interface MkGeoIPLookupResults()

@property mkgeoip_lookup_results_t *results;

@end  // interface MkGeoIPLookupResults

@implementation MkGeoIPLookupResults

-(id)initWithPointer:(mkgeoip_lookup_results_t *)res {
  if ((self = [super init]) != nil) {
    self.results = res;
    if (self.results == NULL) abort();
  }
  return self;
}

-(BOOL)good {
  return mkgeoip_lookup_results_good_v2(self.results);
}

-(double)getBytesSent {
  return mkgeoip_lookup_results_get_bytes_sent_v2(self.results);
}

-(double)getBytesRecv {
  return mkgeoip_lookup_results_get_bytes_recv_v2(self.results);
}

-(NSString *)getProbeIP {
  const char *s = mkgeoip_lookup_results_get_probe_ip_v2(self.results);
  if (s == NULL) abort();
  return [NSString stringWithUTF8String:s];
}

-(int64_t)getProbeASN {
  return mkgeoip_lookup_results_get_probe_asn_v2(self.results);
}

-(NSString *)getProbeCC {
  const char *s = mkgeoip_lookup_results_get_probe_cc_v2(self.results);
  if (s == NULL) abort();
  return [NSString stringWithUTF8String:s];
}

-(NSString *)getProbeOrg {
  const char *s = mkgeoip_lookup_results_get_probe_org_v2(self.results);
  if (s == NULL) abort();
  return [NSString stringWithUTF8String:s];
}

-(NSData *)getLogs {
  const uint8_t *base = NULL;
  size_t count = 0;
  mkgeoip_lookup_results_get_logs_binary_v2(self.results, &base, &count);
  if (base == NULL || count <= 0 || count > NSIntegerMax) abort();
  return [NSData dataWithBytes:(const void *)base length:count];
}

-(void)deinit {
  mkgeoip_lookup_results_delete(self.results);
}

@end  // implementation MkGeoIPLookupResults

@interface MkGeoIPLookupSettings()

@property mkgeoip_lookup_settings_t *settings;

@end  // interface MkGeoIPLookupSettings

@implementation MkGeoIPLookupSettings

-(id)init {
  if ((self = [super init]) != nil) {
    self.settings = mkgeoip_lookup_settings_new_nonnull();
    if (self.settings == NULL) abort();
    NSString *CABundlePath = [MkResources getCABundlePath];
    NSString *MMDBASNPath = [MkResources getMMDBASNPath];
    NSString *MMDBCountryPath = [MkResources getMMDBCountryPath];
    if (CABundlePath == nil || MMDBASNPath == nil || MMDBCountryPath == nil) {
      abort();
    }
    mkgeoip_lookup_settings_set_ca_bundle_path_v2(
      self.settings, [CABundlePath UTF8String]);
    mkgeoip_lookup_settings_set_asn_db_path_v2(
      self.settings, [MMDBASNPath UTF8String]);
    mkgeoip_lookup_settings_set_country_db_path_v2(
      self.settings, [MMDBCountryPath UTF8String]);
  }
  return self;
}

-(void)setTimeout:(int64_t)timeout {
  mkgeoip_lookup_settings_set_timeout_v2(self.settings, timeout);
}

-(MkGeoIPLookupResults *)perform {
  return [[MkGeoIPLookupResults alloc]
    initWithPointer:mkgeoip_lookup_settings_perform_nonnull(self.settings)];
}

-(void)deinit {
  mkgeoip_lookup_settings_delete(self.settings);
}

@end  // implementation MkGeoIPLookupSettings


// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "vendor/mkcollector.hpp"

#import "MKReporterInternal.h"
#import "MKResources.h"
#import "MKUtil.hpp"

@implementation MKReporterResults
@end // @implementation MKReporterResults

MKUTIL_EXTEND_CLASS(MKReporterTask, mk::collector::Reporter);

@implementation MKReporterTask

-(instancetype)initWithSoftwareName:(NSString *)softwareName
                    softwareVersion:(NSString *)softwareVersion {
  if (softwareName == nil || softwareVersion == nil) {
    abort();
  }
  if ((self = [self init]) != nil) {
    self.impl = new mk::collector::Reporter(
      [softwareName UTF8String], [softwareVersion UTF8String]
    );
    self.impl->set_ca_bundle_path([[MKResources caBundlePath] UTF8String]);
  }
  return self;
}

-(MKReporterResults *)submit:(NSString *)measurement
               uploadTimeout:(int64_t)timeout{
  return [self submitWithMeasurement:measurement
                       uploadTimeout:timeout
                               stats:nil];
}

-(MKReporterResults *)submitWithMeasurement:(NSString *)measurement
                              uploadTimeout:(int64_t)timeout
                                      stats:(NSMutableDictionary *)pstats {
  if (measurement == nil) {
    abort();
  }
  std::string m = [measurement UTF8String];
  std::vector<std::string> logs;
  MKReporterResults *results = [[MKReporterResults alloc] init];
  mk::collector::Reporter::Stats stats;
  std::string reason;
  results.good = self.impl->maybe_discover_and_submit_with_stats_and_reason(
    m, logs, timeout, stats, reason);
  results.reason = [NSString stringWithUTF8String:reason.c_str()];
  results.updatedSerializedMeasurement = [
    NSString stringWithUTF8String:m.c_str()
  ];
  results.updatedReportID = [
    NSString stringWithUTF8String:self.impl->report_id().c_str()
  ];
  results.logs = mkutil_make_logs(logs);
  if (pstats != nil) {
#define XX(name_) do { \
    [pstats setObject:[NSNumber numberWithLong:stats.name_] forKey:@#name_]; \
  } while (0);
    MKCOLLECTOR_REPORTER_STATS_ENUM(XX)
#undef XX
  }
  return results;
}

MKUTIL_DEALLOC([](mk::collector::Reporter *r) {
  delete r; // handles nullptr gracefully
})

@end // @implementation MKReporterTask

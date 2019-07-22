// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKReporterInternal.h"

#import "MKResources.h"
#import "MKUtil.hpp"

MKUTIL_EXTEND_CLASS(MKReporterSettings, mk::collector::Settings);

@implementation MKReporterSettings

MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY(
  []() -> mk::collector::Settings *{
    return new mk::collector::Settings;
  }, [](mk::collector::Settings *p, const char *v) {
    p->ca_bundle_path = v;
  }, [](mk::collector::Settings *, const char *) {
    // NOTHING
  }, [](mk::collector::Settings *, const char *) {
    // NOTHING
  })

MKUTIL_SET_STRING(setBaseURL, [](mk::collector::Settings *p, const char *v) {
  p->base_url = v;
})

MKUTIL_SET_INT(setTimeout, [](mk::collector::Settings *p, int64_t v) {
  p->timeout = v;
})

MKUTIL_DEINIT([](mk::collector::Settings *s) {
  delete s; // handles nullptr gracefully
})

@end // @implementation MKReporterSettings

@implementation MKReporterResults
@end // @implementation MKReporterResults

MKUTIL_EXTEND_CLASS(MKReporterTask, mk::collector::Reporter);

@implementation MKReporterTask

-(instancetype)initWithSettings:(MKReporterSettings *)settings
                   softwareName:(NSString *)softwareName
                softwareVersion:(NSString *)softwareVersion {
  if (settings == nil || settings.impl == nil ||
      softwareName == nil || softwareVersion == nil) {
    abort();
  }
  if (([self init]) != nil) {
    self.impl = new mk::collector::Reporter(
      *settings.impl, [softwareName UTF8String], [softwareVersion UTF8String]
    );
  }
  return self;
}

-(MKReporterResults *)submit:(NSString *)measurement {
  return [self submitWithMeasurement:measurement andStats:nil];
}

-(MKReporterResults *)submitWithMeasurement:(NSString *)measurement
                                   andStats:(MKReporterStats *)pstats {
  if (measurement == nil) {
    abort();
  }
  std::string m = [measurement UTF8String];
  std::vector<std::string> logs;
  MKReporterResults *results = [[MKReporterResults alloc] init];
  mk::collector::Reporter::Stats stats;
  results.good = self.impl->submit_with_stats(m, logs, stats);
  results.updatedSerializedMeasurement = [
    NSString stringWithUTF8String:m.c_str()
  ];
  results.updatedReportID = [
    NSString stringWithUTF8String:self.impl->report_id().c_str()
  ];
  results.logs = mkutil_make_logs(logs);
  if (pstats != nil) {
    *pstats = {}; // zero the structure just in case
#define XX(name_) pstats->name_ = stats.name_;
    MKCOLLECTOR_REPORTER_STATS_ENUM(XX)
#undef XX
  }
  return results;
}

MKUTIL_DEINIT([](mk::collector::Reporter *r) {
  delete r; // handles nullptr gracefully
})

@end // @implementation MKReporterTask

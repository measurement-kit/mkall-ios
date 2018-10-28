// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "mkgeoip.h"
#import "mkall.h"

@interface mkgeoipTests : XCTestCase

@end

@implementation mkgeoipTests

- (void)testMkGeoip {
  mkgeoip_lookup_settings_uptr settings{mkgeoip_lookup_settings_new()};
  XCTAssert(settings != nullptr);
  mkgeoip_lookup_settings_set_ca_bundle_path(settings.get(),
    [[MkResources getCABundlePath] UTF8String]);
  mkgeoip_lookup_settings_set_country_db_path(settings.get(),
    [[MkResources getMMDBCountryPath] UTF8String]);
  mkgeoip_lookup_settings_set_asn_db_path(settings.get(),
    [[MkResources getMMDBASNPath] UTF8String]);
  mkgeoip_lookup_results_uptr results{
    mkgeoip_lookup_settings_perform(settings.get())};
  XCTAssert(results != nullptr);
  XCTAssert(mkgeoip_lookup_results_good(results.get()));
  {
    const char *probe_ip = mkgeoip_lookup_results_get_probe_ip(results.get());
    XCTAssert(probe_ip != nullptr);
    NSLog(@"probe_ip: %s", probe_ip);
  }
  {
    int64_t probe_asn = mkgeoip_lookup_results_get_probe_asn(results.get());
    XCTAssert(probe_asn != 0);
    NSLog(@"probe_asn: %lld", probe_asn);
  }
  {
    const char *probe_cc = mkgeoip_lookup_results_get_probe_cc(results.get());
    XCTAssert(probe_cc != nullptr);
    NSLog(@"probe_cc: %s", probe_cc);
  }
  {
    const char *probe_org = mkgeoip_lookup_results_get_probe_org(results.get());
    XCTAssert(probe_org != nullptr);
    NSLog(@"probe_org: %s", probe_org);
  }
  {
    std::string logs;
    XCTAssert(mkgeoip_lookup_results_moveout_logs(results.get(), &logs));
    NSLog(@"%s", logs.c_str());
  }
}

@end


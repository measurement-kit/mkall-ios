// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKGeoIPLookup.h"

@interface MKGeoIPLookupTests : XCTestCase

@end

@implementation MKGeoIPLookupTests

- (void)testMKResources {
  MKGeoIPLookupTask *task = [[MKGeoIPLookupTask alloc] init];
  [task setTimeout:17];
  MKGeoIPLookupResults *results = [task perform];
  XCTAssert([results good]);
  {
    NSString *s = [results probeIP];
    XCTAssert(s != nil);
    NSLog(@"probe_ip: %@", s);
  }
  {
    NSString *s = [results probeCC];
    XCTAssert(s != nil);
    NSLog(@"probe_cc: %@", s);
  }
  {
    NSString *s = [results probeOrg];
    XCTAssert(s != nil);
    NSLog(@"probe_org: %@", s);
  }
  {
    NSString *s = [results probeASN];
    XCTAssert(s != nil);
    NSLog(@"probe_asn: %@", s);
  }
  {
    NSString *s = [results logs];
    XCTAssert(s != nil);
    NSLog(@"logs: %@", s);
  }
}

@end

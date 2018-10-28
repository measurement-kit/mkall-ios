// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MkGeoIPLookup.h"

@interface mkGeoIPLookupTests : XCTestCase

@end

@implementation mkGeoIPLookupTests

- (void)testMkResources {
  MkGeoIPLookupSettings *settings = [[MkGeoIPLookupSettings alloc] init];
  [settings setTimeout:17];
  MkGeoIPLookupResults *results = [settings perform];
  XCTAssert([results good]);
  {
    NSString *s = [results getProbeIP];
    XCTAssert(s != nil);
    NSLog(@"probe_ip: %@", s);
  }
  {
    NSString *s = [results getProbeCC];
    XCTAssert(s != nil);
    NSLog(@"probe_cc: %@", s);
  }
  {
    NSString *s = [results getProbeOrg];
    XCTAssert(s != nil);
    NSLog(@"probe_org: %@", s);
  }
  {
    int64_t n = [results getProbeASN];
    XCTAssert(n != 0);
    NSLog(@"probe_asn: %lld", n);
  }
  {
    double v = [results getBytesRecv];
    XCTAssert(v > 0.0);
    NSLog(@"bytes_recv: %f", v);
  }
  {
    double v = [results getBytesSent];
    XCTAssert(v > 0.0);
    NSLog(@"bytes_sent: %f", v);
  }
  {
    NSData *d = [results getLogs];
    NSString *s = [[NSString alloc] initWithData:d
        encoding:NSUTF8StringEncoding];
    XCTAssert(d != nil && s != nil);
    NSLog(@"logs: %@", s);
  }
}

@end

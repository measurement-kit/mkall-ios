// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKOrchestra.h"

@interface MKOrchestraTest : XCTestCase

@end

@implementation MKOrchestraTest

- (void)testMKResources {
  MKOrchestraClient *client = [[MKOrchestraClient alloc] init];
  [client setAvailableBandwidth:@"10110111"];
  [client setDeviceToken:@"5f2c761f-2e98-43aa-b9ea-3d34cceaab15"];
  [client setLanguage:@"it_IT"];
  [client setNetworkType:@"wifi"];
  [client setPlatform:@"macos"];
  // Disabled so that the library will need to guess them
  //[client setProbeASN:@"AS30722"];
  //[client setProbeCC:@"IT"];
  [client setProbeFamily:@"sbs"];
  [client setProbeTimezone:@"Europe/Rome"];
  [client setRegistryURL:@"https://registry.proteus.test.ooni.io"];
  [client setSecretsFile:@".orchestra.json"];  // XXX
  [client setSoftwareName:@"mkall-ios"];
  [client setSoftwareVersion:@"0.1.0"];
  [client addSupportedTest:@"web_connectivity"];
  [client addSupportedTest:@"ndt"];
  [client setTimeout:14];
  {
    MKOrchestraResult *result = [client sync];
    NSLog(@"Good: %d", [result good]);
    NSData *d = [result getLogs];
    NSString *s = [[NSString alloc] initWithData:d
        encoding:NSUTF8StringEncoding];
    XCTAssert(d != nil && s != nil);
    NSLog(@"logs: %@", s);
  }
  [client setNetworkType:@"mobile"];
  {
    MKOrchestraResult *result = [client sync];
    NSLog(@"Good: %d", [result good]);
    NSData *d = [result getLogs];
    NSString *s = [[NSString alloc] initWithData:d
        encoding:NSUTF8StringEncoding];
    XCTAssert(d != nil && s != nil);
    NSLog(@"logs: %@", s);
  }
}

@end

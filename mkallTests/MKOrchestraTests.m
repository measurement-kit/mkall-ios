// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKOrchestra.h"

@interface MKOrchestraTest : XCTestCase

@end

@implementation MKOrchestraTest

- (NSString*)getNonexistentSecretsFilePath {
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",
                          NSHomeDirectory(),
                          @"orchestrator_secret.json"];
    XCTAssert(filePath != nil);
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    // Ignore the error. We want the file NOT to exist, if it happens to
    // exist, because we want to test also the register case.
    return filePath;
}

- (void)testMKResources {
  NSString *secretsFilePath = [self getNonexistentSecretsFilePath];
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
  [client setSecretsFile:secretsFilePath];
  [client setSoftwareName:@"mkall-ios"];
  [client setSoftwareVersion:@"0.1.0"];
  [client addSupportedTest:@"web_connectivity"];
  [client addSupportedTest:@"ndt"];
  [client setTimeout:14];
  {
    MKOrchestraResult *result = [client updateOrRegister];
    XCTAssert([result good]);
    NSLog(@"Good: %d", [result good]);
    NSString *s = [result logs];
    XCTAssert(s != nil);
    NSLog(@"logs: %@", s);
  }
  [client setNetworkType:@"mobile"];
  {
    MKOrchestraResult *result = [client updateOrRegister];
    XCTAssert([result good]);
    NSLog(@"Good: %d", [result good]);
    NSString *s = [result logs];
    XCTAssert(s != nil);
    NSLog(@"logs: %@", s);
  }
}

@end

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
  MKOrchestraTask *settings = [[MKOrchestraTask alloc]
      initWithSoftwareName:@"mkall-ios"
           softwareVersion:@"0.1.0"
            supportedTests:@[@"ndt", @"web_connectivity"]
               deviceToken:@"5f2c761f-2e98-43aa-b9ea-3d34cceaab15"
               secretsFile:secretsFilePath
  ];
  [settings setAvailableBandwidth:@"10110111"];
  [settings setLanguage:@"it_IT"];
  [settings setNetworkType:@"wifi"];
  [settings setPlatform:@"macos"];
  // Disabled so that the library will need to guess them
  //[settings setProbeASN:@"AS30722"];
  //[settings setProbeCC:@"IT"];
  [settings setProbeFamily:@"sbs"];
  [settings setProbeTimezone:@"Europe/Rome"];
  [settings setRegistryURL:@"https://registry.proteus.test.ooni.io"];
  [settings setTimeout:14];
  {
    MKOrchestraResults *result = [settings updateOrRegister];
    XCTAssert([result good]);
    NSLog(@"Good: %d", [result good]);
    NSString *s = [result logs];
    XCTAssert(s != nil);
    NSLog(@"logs: %@", s);
  }
  [settings setNetworkType:@"mobile"];
  {
    MKOrchestraResults *result = [settings updateOrRegister];
    XCTAssert([result good]);
    NSLog(@"Good: %d", [result good]);
    NSString *s = [result logs];
    XCTAssert(s != nil);
    NSLog(@"logs: %@", s);
  }
}

@end

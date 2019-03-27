// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKResources.h"

@interface MKResourcesTests : XCTestCase

@end

@implementation MKResourcesTests

- (void)testMKResources {
  XCTAssert([MKResources mmdbCountryPath] != nil);
  XCTAssert([MKResources mmdbASNPath] != nil);
  XCTAssert([MKResources caBundlePath] != nil);
}

@end

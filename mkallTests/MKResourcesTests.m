// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKResources.h"

@interface mkResourcesTests : XCTestCase

@end

@implementation mkResourcesTests

- (void)testMKResources {
  XCTAssert([MKResources getMMDBCountryPath] != nil);
  XCTAssert([MKResources getMMDBASNPath] != nil);
  XCTAssert([MKResources getCABundlePath] != nil);
}

@end

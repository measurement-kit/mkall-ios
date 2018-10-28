// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MkResources.h"

@interface mkallTests : XCTestCase

@end

@implementation mkallTests

- (void)testMkResources {
  XCTAssert([MkResources getMMDBCountryPath] != nil);
  XCTAssert([MkResources getMMDBASNPath] != nil);
  XCTAssert([MkResources getCABundlePath] != nil);
}

@end

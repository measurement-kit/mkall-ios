// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "mkall.h"

@interface mkallTests : XCTestCase

@end

@implementation mkallTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)testMkResources {
  XCTAssert([MkResources getMMDBCountryPath] != nil);
  XCTAssert([MkResources getMMDBASNPath] != nil);
  XCTAssert([MkResources getCABundlePath] != nil);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MkTask.h"
#import "MkResources.h"

@interface mkTaskTests : XCTestCase

@end

@implementation mkTaskTests

- (void)testMkTask {
  NSDictionary *settings = @{
    @"log_level": @"DEBUG",
    @"name": @"Ndt",
    @"options": @{
      @"no_file_report": @YES,
      @"net/ca_bundle_path": [MkResources getCABundlePath],
    }
  };
  MkTask *task = [MkTask startNettest:settings];
  XCTAssert(task != nil);
  while (![task isDone]) {
    NSDictionary *event = [task waitForNextEvent];
    XCTAssert(event != nil);
    NSLog(@"%@", event);
  }
}

@end

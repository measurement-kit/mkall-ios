// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKAsyncTask.h"
#import "MKResources.h"

@interface MKAsyncTaskTests : XCTestCase

@end

@implementation MKAsyncTaskTests

- (void)logEvent:(NSDictionary *)event {
  NSLog(@"%@", event);
}

- (void)testMKAsyncTaskNDT {
  NSDictionary *settings = @{
    @"log_level": @"INFO",
    @"name": @"Ndt",
    @"options": @{
      @"no_file_report": @YES,
      @"net/ca_bundle_path": [MKResources caBundlePath],
    }
  };
  MKAsyncTask *task = [MKAsyncTask start:settings];
  XCTAssert(task != nil);
  while (![task isDone]) {
    NSDictionary *event = [task waitForNextEvent];
    XCTAssert(event != nil);
    [self logEvent:event];
  }
}

- (void)testMKAsyncTaskWebConnectivity {
  NSDictionary *settings = @{
    @"log_level": @"INFO",
    @"name": @"WebConnectivity",
    @"inputs": @[
      @"http://www.kernel.org",
      @"http://www.slashdot.org"
    ],
    @"options": @{
      @"no_file_report": @YES,
      @"net/ca_bundle_path": [MKResources caBundlePath],
    }
  };
  MKAsyncTask *task = [MKAsyncTask start:settings];
  XCTAssert(task != nil);
  while (![task isDone]) {
    NSDictionary *event = [task waitForNextEvent];
    XCTAssert(event != nil);
    [self logEvent:event];
  }
}

@end
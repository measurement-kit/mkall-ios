// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKCollector.h"

@interface MKCollectorTests : XCTestCase

@end

static const char *serializedJSON = R"({
  "data_format_version": "0.2.0",
  "input": "torproject.org",
  "measurement_start_time": "2016-06-04 17:53:13",
  "probe_asn": "AS0",
  "probe_cc": "ZZ",
  "probe_ip": "127.0.0.1",
  "software_name": "measurement_kit",
  "software_version": "0.2.0-alpha.1",
  "test_keys": {"failure": null,"received": [],"sent": []},
  "test_name": "tcp_connect",
  "test_runtime": 0.253494024276733,
  "test_start_time": "2016-06-04 17:53:13",
  "test_version": "0.0.1"
})";

@implementation MKCollectorTests

- (void)testResubmission {
  MKCollectorResubmitTask *settings = [
    [MKCollectorResubmitTask alloc] initWithSerializedMeasurement:[
      NSString stringWithUTF8String:serializedJSON]];
  MKCollectorResubmitResults *results = [settings perform];
  XCTAssert([results good]);
  NSLog(@"good: %d", [results good]);
  NSLog(@"updatedMeasurement: %@", [results updatedSerializedMeasurement]);
  NSLog(@"updatedReportID: %@", [results updatedReportID]);
  NSLog(@"logs: %@", [results logs]);
}

@end

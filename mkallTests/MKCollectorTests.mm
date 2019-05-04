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

- (void)testResubmissionGood {
  MKCollectorResubmitSettings *settings = [
    [MKCollectorResubmitSettings alloc] init];
  [settings setSerializedMeasurement:[
    NSString stringWithUTF8String:serializedJSON]];
  [settings setSoftwareName:@"ooniprobe-ios"];
  [settings setSoftwareVersion:@"2.0.1"];
  MKCollectorResubmitResults *results = [settings perform];
  XCTAssert([results good]);
  NSLog(@"good: %d", [results good]);
  NSLog(@"updatedMeasurement: %@", [results updatedSerializedMeasurement]);
  NSLog(@"updatedReportID: %@", [results updatedReportID]);
  NSLog(@"logs: %@", [results logs]);
}

// Ensure that we cannot resubmit if we're ooniprobe-android 2.0.0. This
// is mainly to be sure that we can set software name and version.
- (void)testResubmissionBad {
  MKCollectorResubmitSettings *settings = [
    [MKCollectorResubmitSettings alloc] init];
  [settings setSerializedMeasurement:[
    NSString stringWithUTF8String:serializedJSON]];
  [settings setSoftwareName:@"ooniprobe-android"];
  [settings setSoftwareVersion:@"2.0.0"];
  MKCollectorResubmitResults *results = [settings perform];
  XCTAssert(![results good]);
  NSLog(@"good: %d", [results good]);
  NSLog(@"updatedMeasurement: %@", [results updatedSerializedMeasurement]);
  NSLog(@"updatedReportID: %@", [results updatedReportID]);
  NSLog(@"logs: %@", [results logs]);
}
@end

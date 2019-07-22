// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <Foundation/Foundation.h>

#import <XCTest/XCTest.h>

#import "MKReporterInternal.h"

// This is a C++11 raw string; hence this file is ObjectiveC++.
static const char *firstMeasurement = R"({
  "data_format_version": "0.2.0",
  "input": "torproject.org",
  "measurement_start_time": "2016-06-04 17:53:13",
  "probe_asn": "AS0",
  "probe_cc": "ZZ",
  "probe_ip": "127.0.0.1",
  "software_name": "measurement_kit",
  "software_version": "0.2.0-alpha.1",
  "test_keys": {"failure": null,"received": [],"sent": []},
  "test_name": "dummy",
  "test_runtime": 0.253494024276733,
  "test_start_time": "2016-06-04 17:53:13",
  "test_version": "0.0.1"
})";

static const char *secondMeasurement = R"({
  "data_format_version": "0.2.0",
  "input": "kernel.org",
  "measurement_start_time": "2016-06-04 17:53:13",
  "probe_asn": "AS0",
  "probe_cc": "ZZ",
  "probe_ip": "127.0.0.1",
  "software_name": "measurement_kit",
  "software_version": "0.2.0-alpha.1",
  "test_keys": {"failure": null,"received": [],"sent": []},
  "test_name": "dummy",
  "test_runtime": 0.253494024276733,
  "test_start_time": "2016-06-04 17:53:13",
  "test_version": "0.0.1"
})";

static const char *thirdMeasurement = R"({
  "data_format_version": "0.2.0",
  "input": "kernel.org",
  "measurement_start_time": "2016-06-04 17:53:13",
  "probe_asn": "AS0",
  "probe_cc": "ZZ",
  "probe_ip": "127.0.0.1",
  "software_name": "measurement_kit",
  "software_version": "0.2.0-alpha.1",
  "test_keys": {"failure": null,"received": [],"sent": []},
  "test_name": "gummy",
  "test_runtime": 0.253494024276733,
  "test_start_time": "2016-06-04 17:53:13",
  "test_version": "0.0.1"
})";

// Utility function to create a task with specific configuration
static MKReporterTask *makeTask(
    NSString *softwareName, NSString *softwareVersion) {
  MKReporterSettings *settings = [[MKReporterSettings alloc] init];
  MKReporterTask *reporter = [
    [MKReporterTask alloc] initWithSettings:settings
                               softwareName:softwareName
                            softwareVersion:softwareVersion
  ];
  return reporter;
}

// Utility function to create a measurement from a C string
static NSString *makeMeasurement(const char *m) {
  return [NSString stringWithUTF8String:m];
}

@interface MKReporterTests : XCTestCase
@end // @interface MKReporterTests

@implementation MKReporterTests

// Utility function to submit a measurement with an existing task.
- (void)submissionWithTask:(MKReporterTask *)task
               measurement:(NSString *)measurement
            expectedResult:(BOOL)expectedResult
             expectedStats:(MKReporterStats *)expectedStats {
  MKReporterStats stats{};
  MKReporterResults *results = [
    task submitWithMeasurement:measurement andStats:&stats
  ];
  NSLog(@"logs: %@", [results logs]);
  NSLog(@"=== BEGIN VARIABLES ===");
  NSLog(@"good: %d", [results good]);
  NSLog(@"updatedSerializedMeasurement: %@", [
    results updatedSerializedMeasurement
  ]);
  NSLog(@"updatedReportID: %@", [results updatedReportID]);
  NSLog(@"=== END VARIABLES ===");
  XCTAssert([[results logs] length] > 0);
  XCTAssert([results good] == expectedResult);
  if ([results good]) {
    NSString *rid = [results updatedReportID];
    XCTAssert([rid length] > 0);
    XCTAssert([[results updatedSerializedMeasurement] containsString:rid]);
  }
#define XX(name_) XCTAssert(stats.name_ == expectedStats->name_);
  MKCOLLECTOR_REPORTER_STATS_ENUM(XX)
#undef XX
}

// Utility function to submit just a single measurement.
- (void)simpleSubmission:(NSString *)measurement
            softwareName:(NSString *)softwareName
         softwareVersion:(NSString *)softwareVersion
          expectedResult:(BOOL)expectedResult
           expectedStats:(MKReporterStats *)expectedStats {
  return [self submissionWithTask:makeTask(softwareName, softwareVersion)
                      measurement:measurement
                   expectedResult:expectedResult
                    expectedStats:expectedStats];
}

// Ensure that we can submit a single measurement.
- (void)testResubmissionGood {
  MKReporterStats stats{};
  stats.bouncer_okay = 1;
  stats.load_request_okay = 1;
  stats.open_report_okay = 1;
  stats.update_report_okay = 1;
  [self simpleSubmission:makeMeasurement(firstMeasurement)
            softwareName:@"ooniprobe-ios"
         softwareVersion:@"2.0.1"
          expectedResult:YES
           expectedStats:&stats];
}

// Ensure that we cannot resubmit if we're ooniprobe-android 2.0.0. This
// is mainly to be sure that we can set software name and version.
- (void)testResubmissionBad {
  MKReporterStats stats{};
  stats.bouncer_okay = 1;
  stats.load_request_okay = 1;
  stats.open_report_error = 1;
  [self simpleSubmission:makeMeasurement(firstMeasurement)
            softwareName:@"ooniprobe-android"
         softwareVersion:@"2.0.0"
          expectedResult:NO
           expectedStats:&stats];
}

// Ensure that we can resubmit many measurements.
- (void)testResubmissionMany {
  MKReporterTask *task = makeTask(@"ooniprobe-ios", @"2.0.1");
  {
    MKReporterStats stats{};
    stats.bouncer_okay = 1;
    stats.load_request_okay = 1;
    stats.open_report_okay = 1;
    stats.update_report_okay = 1;
    [self submissionWithTask:task
                 measurement:makeMeasurement(firstMeasurement)
              expectedResult:YES
               expectedStats:&stats];
  }
  {
    MKReporterStats stats{};
    stats.load_request_okay = 1;
    stats.update_report_okay = 1;
    [self submissionWithTask:task
                 measurement:makeMeasurement(secondMeasurement)
              expectedResult:YES
               expectedStats:&stats];
  }
  {
    MKReporterStats stats{};
    stats.load_request_okay = 1;
    stats.close_report_okay = 1;
    stats.open_report_okay = 1;
    stats.update_report_okay = 1;
    [self submissionWithTask:task
                 measurement:makeMeasurement(thirdMeasurement)
              expectedResult:YES
               expectedStats:&stats];
  }
}

@end // @implementation MKReporterTests

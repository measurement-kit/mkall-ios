// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKReporter_h
#define MKReporter_h

#import <Foundation/Foundation.h>

/// MKReporterResults contains the results of running MKReporterTask.
@interface MKReporterResults : NSObject

/// good indicates whether the operation was successful.
@property BOOL good;

/// updatedSerializedMeasurement is the updated serialized measurement
/// content where fields like the report ID have been updated taking into
/// account the information that has been returned by the collector.
@property NSString *updatedSerializedMeasurement;

/// updatedReportID is the updated report ID.
@property NSString *updatedReportID;

/// logs contains logs useful to debug failures.
@property NSString *logs;

@end // @interface MKReporterResults

/// MKReporterTask is a task for submitting reports. You should create an
/// instance of this class to submit one or more reports. Reuse this class
/// for all reports. Keep in mind that this is not thread safe, though.
@interface MKReporterTask : NSObject

/// initWithSoftwareName:softwareVersion initializes the task with the name
/// and the version of the app performing the measurements submission.
-(instancetype)initWithSoftwareName:(NSString *)softwareName
                    softwareVersion:(NSString *)softwareVersion;

/// submit:uploadTimeout: submits @p measurement and returns the results. This
/// class will take care of opening a new report and possibly closing a report
/// that was previously open when the measurement does not belong to the same
/// report of previously submitted measurements. The @p uploadTimeout argument
/// controls the number of seconds after which the upload is interrupted. If
/// you set zero as timeout, the timeout will be infinite.
-(MKReporterResults *)submit:(NSString *)measurement
               uploadTimeout:(int64_t)timeout;

@end // @interface MKReporterTask

#endif /* MKReporter_h */

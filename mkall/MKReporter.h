// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKReporter_h
#define MKReporter_h

#import <Foundation/Foundation.h>

/// MKReporterSettings contains the settings of MKReporterTask.
@interface MKReporterSettings : NSObject

/// init initializes the settings with default values.
-(instancetype)init;

/// setBaseURL sets the optional collector base URL. If no base URL is
/// provided, we will try to discover a base URL using the bouncer.
-(void)setBaseURL:(NSString *)baseURL;

/// setTimeout sets the optional per-request timeout. By default we
/// don't set any timeout for submitting measurements.
-(void)setTimeout:(int64_t)timeout;

@end // @interface MKReporterSettings

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

/// initWithSettings initializes the task with specific settings as well as
/// with the name and the version of the app performing the submission.
-(instancetype)initWithSettings:(MKReporterSettings *)settings
                   softwareName:(NSString *)softwareName
                softwareVersion:(NSString *)softwareVersion;

/// submit submits the specified measurement and returns the results. This
/// class will take care of opening a new report and possibly closing a report
/// that was previously open when the measurement does not belong to the same
/// report of previously submitted measurements.
-(MKReporterResults *)submit:(NSString *)measurement;

@end // @interface MKReporterTask

#endif /* MKReporter_h */

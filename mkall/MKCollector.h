// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKCollector_h
#define MKCollector_h

#import <Foundation/Foundation.h>

/// MKCollectorResubmitResults contains the results of resubmitting
/// a single measurement to the OONI collector.
@interface MKCollectorResubmitResults : NSObject

/// good returns whether the operation was successful.
-(BOOL)good;

/// updatedSerializedMeasurement returns the updated serialized measurement
/// content where fields like the report ID have been updated taking into
/// account the information that has been returned by the collector.
-(NSString *)updatedSerializedMeasurement;

/// updatedReportID returns the updated report ID.
-(NSString *)updatedReportID;

/// logs contains logs useful to debug failures.
-(NSString *)logs;

@end  // interface MKCollectorResponse

/// MKCollectorResubmitTask is a sync task that resubmits
/// a measurement to the OONI collector.
@interface MKCollectorResubmitTask : NSObject

/// initWithSerializedMeasurement initializes the task using the
/// serialized measurement that should be uploaded to the OONI collector,
/// the software name and the software version of the app.
-(instancetype)initWithSerializedMeasurement:(NSString *)content
                                softwareName:(NSString *)softwareName
                             softwareVersion:(NSString *)softwareVersion;

/// setSerializedMeasurement sets the serialized measurement that
/// should be uploaded to the OONI collector.
-(void)setSerializedMeasurement:(NSString *)content;

/// setSoftwareName sets the name of the app that is resubmitting.
-(void)setSoftwareName:(NSString *)content;

/// setSoftwareVersion sets the version of the app that is resubmitting.
-(void)setSoftwareVersion:(NSString *)content;

/// setTimeout sets the number of seconds after which an operation is aborted.
-(void)setTimeout:(int64_t)timeout;

/// perform resubmits the selected measurement to the OONI collector
/// using the current value of the settings.
-(MKCollectorResubmitResults *)perform;

@end  // interface MKCollectorResubmitTask

#endif /* MKCollector_h */

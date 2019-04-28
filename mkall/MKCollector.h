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

-(void)deinit;

@end  // interface MKCollectorResponse

/// MKCollectorResubmitTask is a sync task that resubmits
/// a measurement to the OONI collector.
@interface MKCollectorResubmitTask : NSObject

-(id)init;

/// setSerializedMeasurement sets the serialized measurement that
/// should be uploaded to the OONI collector.
-(void)setSerializedMeasurement:(NSString *)content;

/// setTimeout sets the number of seconds after which an operation is aborted.
-(void)setTimeout:(int64_t)timeout;

/// perform resubmits the selected measurement to the OONI collector
/// using the current value of the settings.
-(MKCollectorResubmitResults *)perform;

-(void)deinit;

@end  // interface MKCollectorResubmitTask

#endif /* MKCollector_h */

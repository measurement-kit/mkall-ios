// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKTask_h
#define MKTask_h

#import <Foundation/Foundation.h>

/// MKTask is a task run by Measurement Kit.
///
/// We generally use tasks only for running nettests. A task receives
/// input configuration as a JSON and emits JSON events.
///
/// See https://github.com/measurement-kit/measurement-kit/tree/master/include/measurement_kit
@interface MKTask : NSObject

/// start starts a task with the specified settings.
///
/// Returns the running task. Note that in some error cases the
/// returned value may also be nil.
+ (MKTask *)start:(NSDictionary *)data;

/// isDone returns TRUE when the task is done, false otherwise.
- (BOOL)isDone;

/// waitForNextEvent blocks until the task emits the next event.
///
/// The returned value is an event and it may also be nil
/// under some unspecified, severe error conditions.
- (NSDictionary *)waitForNextEvent;

/// interrupt interrups a running task.
///
/// As of MK v0.10.0, not all tasks support being interrupted
/// and and may therefore ignore the interrupt signal.
- (void)interrupt;

- (void)deinit;

@end  // interface MKTask

#endif /* MKTask_h */

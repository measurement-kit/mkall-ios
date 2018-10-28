// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MkTask_h
#define MkTask_h

#import <Foundation/Foundation.h>

@interface MkTask : NSObject

+ (MkTask *)startNettest:(NSDictionary *)data;

- (BOOL)isDone;

- (NSDictionary *)waitForNextEvent;

- (void)interrupt;

- (void)deinit;

@end  // interface MkTask

#endif /* MkTask_h */

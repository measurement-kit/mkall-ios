// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MkResources_h
#define MkResources_h

#import <Foundation/Foundation.h>

@interface MkResources : NSObject

+ (NSString *)getMMDBCountryPath;

+ (NSString *)getMMDBASNPath;

+ (NSString *)getCABundlePath;

@end  // interface MkResources

#endif /* MkResources_h */

// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <Foundation/Foundation.h>

//! Project version number for mkall.
FOUNDATION_EXPORT double mkallVersionNumber;

//! Project version string for mkall.
FOUNDATION_EXPORT const unsigned char mkallVersionString[];

@interface MkResources : NSObject

+ (NSString *)getMMDBCountryPath;

+ (NSString *)getMMDBASNPath;

+ (NSString *)getCABundlePath;

@end  // interface MkResources

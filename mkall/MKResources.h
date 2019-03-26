// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKResources_h
#define MKResources_h

#import <Foundation/Foundation.h>

/// MKResources provides the paths of embedded resources.
@interface MKResources : NSObject

/// getMMDBCountryPath returns the path to the MMDB country database.
+ (NSString *)getMMDBCountryPath;

/// getMMDBASNPath returns the path to the MMDB ASN database.
+ (NSString *)getMMDBASNPath;

/// getCABundlePath returns the path to the embedded CA bundle.
+ (NSString *)getCABundlePath;

@end  // interface MKResources

#endif /* MKResources_h */

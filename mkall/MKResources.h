// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKResources_h
#define MKResources_h

#import <Foundation/Foundation.h>

/// MKResources provides the paths of embedded resources.
@interface MKResources : NSObject

/// mmdbCountryPath returns the path to the MMDB country database.
+ (NSString *)mmdbCountryPath;

/// mmdbBASNPath returns the path to the MMDB ASN database.
+ (NSString *)mmdbASNPath;

/// caBundlePath returns the path to the embedded CA bundle.
+ (NSString *)caBundlePath;

@end  // interface MKResources

#endif /* MKResources_h */

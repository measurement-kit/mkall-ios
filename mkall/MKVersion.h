// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKVersion_h
#define MKVersion_h

#import <Foundation/Foundation.h>

@interface MKVersion : NSObject

// versionMK returns the most recent stable MK tag.
+ (NSString *)versionMK;

// versionMKGit returns the exact commit used to build MK.
+ (NSString *)versionMKGit;

// versionLibevent returns the version of libevent.
+ (NSString *)versionLibevent;

// versionOpenSSL returns the version of OpenSSL.
+ (NSString *)versionOpenSSL;

@end  // interface MKVersion

#endif /* MKVersion_h */

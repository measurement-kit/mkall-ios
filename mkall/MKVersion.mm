// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKVersion.h"

#include "measurement_kit/common/version.h"

@implementation MKVersion

+ (NSString *)versionMK{
  return [[NSString alloc] initWithUTF8String:mk_version()];
}

+ (NSString *)versionMKGit{
  return [[NSString alloc] initWithUTF8String:mk_version_full()];
}

+ (NSString *)versionLibevent{
  return [[NSString alloc] initWithUTF8String:mk_version_libevent()];
}

+ (NSString *)versionOpenSSL{
  return [[NSString alloc] initWithUTF8String:mk_version_openssl()];
}

@end  // implementation MKVersion

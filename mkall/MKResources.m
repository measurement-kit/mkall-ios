// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKResources.h"

@implementation MKResources

+ (NSString *)mmdbCountryPath {
  return [[NSBundle bundleForClass:[MKResources class]]
    pathForResource:@"country" ofType:@"mmdb"];
}

+ (NSString *)mmdbASNPath{
  return [[NSBundle bundleForClass:[MKResources class]]
    pathForResource:@"asn" ofType:@"mmdb"];
}

+ (NSString *)caBundlePath{
  return [[NSBundle bundleForClass:[MKResources class]]
    pathForResource:@"ca-bundle" ofType:@"pem"];
}

@end  // implementation MKResources

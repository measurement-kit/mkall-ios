// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <Foundation/Foundation.h>

#import "mkall.h"

@implementation MkResources

+ (NSString *)getMMDBCountryPath {
  return [[NSBundle bundleForClass:[MkResources class]]
    pathForResource:@"country" ofType:@"mmdb"];
}

+ (NSString *)getMMDBASNPath{
  return [[NSBundle bundleForClass:[MkResources class]]
    pathForResource:@"asn" ofType:@"mmdb"];
}

+ (NSString *)getCABundlePath{
  return [[NSBundle bundleForClass:[MkResources class]]
    pathForResource:@"ca-bundle" ofType:@"pem"];
}

@end  // interface MkResources

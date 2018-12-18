// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "MKVersion.h"

@interface MKVersionTests : XCTestCase

@end

@implementation MKVersionTests

- (void)testMKVersion {
  NSLog(@"MK version MK: %@", [MKVersion versionMK]);
  NSLog(@"MK version MK git: %@", [MKVersion versionMKGit]);
  NSLog(@"MK version libevent: %@", [MKVersion versionLibevent]);
  NSLog(@"MK version OpenSSL: %@", [MKVersion versionOpenSSL]);
}

@end

// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "mkcurl.h"
#import "MkResources.h"

@interface mkcurlTests : XCTestCase

@end

@implementation mkcurlTests

- (void)testMkCurl {
  mkcurl_request_uptr request{mkcurl_request_new()};
  XCTAssert(request != nullptr);
  mkcurl_request_set_url(request.get(), "https://www.google.com/");
  mkcurl_request_set_ca_bundle_path(request.get(),
    [[MkResources getCABundlePath] UTF8String]);
  mkcurl_response_uptr response{mkcurl_request_perform(request.get())};
  XCTAssert(response != nullptr);
  const char *logs = mkcurl_response_get_logs(response.get());
  NSLog(@"%s", logs);
  XCTAssert(mkcurl_response_get_status_code(response.get()) == 200);
}

@end


// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import <XCTest/XCTest.h>

#import "string.h"

#import "mkdata.h"

@interface mkdataTests : XCTestCase

@end

@implementation mkdataTests

- (void)testMkData {
  mkdata_uptr data{mkdata_new()};
  XCTAssert(data != nullptr);
  const char *utf8_string_simple = "Questa è una stringa UTF-8";
  mkdata_set(data.get(), (const uint8_t *)utf8_string_simple,
    strlen(utf8_string_simple));
  XCTAssert(mkdata_contains_valid_utf8(data.get()));
  const char *utf8_string_simple_b64 = "UXVlc3RhIMOoIHVuYSBzdHJpbmdhIFVURi04";
  const uint8_t *base = nullptr;
  size_t count = 0;
  XCTAssert(mkdata_get_base64(data.get(), &base, &count));
  XCTAssert(count == strlen(utf8_string_simple_b64));
  XCTAssert(memcmp(base, utf8_string_simple_b64,
    strlen(utf8_string_simple_b64)) == 0);
}

@end

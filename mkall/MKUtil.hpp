// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.
#ifndef MKUtil_h
#define MKUtil_h

#import <stdint.h>
#import <stdlib.h>

#import <sstream>
#import <string>
#import <vector>

#import <measurement_kit/internal/vendor/mkdata.hpp>

#import "MKResources.h"

// MKUTIL_EXTEND_CLASS generates a private class extension where a specific
// pointer-to-type property is defined. This macros must be used into the
// implementation file, to make sure the property is hidden from the outside.
#define MKUTIL_EXTEND_CLASS(class_name, property_type) \
@interface class_name()                                \
@property property_type *impl;                         \
@end

// Make sure we have ARC enabled because MKUTIL_DEINIT assumes it.
#if !__has_feature(objc_arc)
#error "This code assumes that ARC is enabled"
#endif

// MKUTIL_DEINIT defines the destructor. We assume that ARC is enabled
// therefore we MUST NOT send a deinit message to the parent.
#define MKUTIL_DEINIT(cxx_func) \
-(void)deinit {                 \
  cxx_func(self.impl);          \
}

// MKUTIL_GET_BOOL defines a getter returning boolean.
#define MKUTIL_GET_BOOL(objc_method, cxx_func) \
-(BOOL)objc_method {                           \
  if (self.impl == NULL) abort();              \
  return cxx_func(self.impl) ? YES : NO;       \
}

// MKUTIL_GET_DOUBLE defines a getter returning double.
#define MKUTIL_GET_DOUBLE(objc_method, cxx_func) \
-(double)objc_method {                           \
  if (self.impl == NULL) abort();                \
  return cxx_func(self.impl);                    \
}

// MKUTIL_GET_INT defines a getter returning int64_t.
#define MKUTIL_GET_INT(objc_method, cxx_func) \
-(int64_t)objc_method {                       \
  if (self.impl == NULL) abort();             \
  return cxx_func(self.impl);                 \
}

// TODO(bassosimone): check whether we need to guarantee that
// logs are base64 or we can assume MK's code to already provide
// us with such guarantee.

// mkutil_make_logs converts @p logs to a single string where individual
// logs that are not base64 encoded are converted to base64.
static inline NSString *mkutil_make_logs(
    const std::vector<std::string> &logs) noexcept {
  std::stringstream ss;
  for (std::string s : logs) {
    if (!mk::data::contains_valid_utf8(s)) {
      s = mk::data::base64_encode(std::move(s));
    }
    ss << s << std::endl;
  }
  return [NSString stringWithUTF8String:ss.str().c_str()];
}

// MKUTIL_GET_LOGS defines a getter combining logs together, making
// sure they are UTF-8 strings, and returning them as a single NSString
// where each log line is separated by a newline.
#define MKUTIL_GET_LOGS(objc_method, cxx_size_func, cxx_at_func) \
-(NSString *)objc_method {                                       \
  if (self.impl == NULL) abort();                                \
  std::stringstream buffer;                                      \
  size_t total = cxx_size_func(self.impl);                       \
  for (size_t i = 0; i < total; ++i) {                           \
    const char *s = cxx_at_func(self.impl, i);                   \
    if (s == NULL) abort();                                      \
    std::string str = s;                                         \
    if (!mk::data::contains_valid_utf8(str)) {                   \
      str = mk::data::base64_encode(std::move(str));             \
    }                                                            \
    buffer << str << std::endl;                                  \
  }                                                              \
  return [NSString stringWithUTF8String:buffer.str().c_str()];   \
}

// MKUTIL_GET_LOGS_FROM_DATA defines a getter equivalent to
// MKUTIL_GET_LOGS except that it reads the logs from a
// single C string and therefore has less control with respect
// to making sure that only selected log lines are base64
// encoded if they're not UTF-8.
#define MKUTIL_GET_LOGS_FROM_DATA(objc_method, cxx_func)    \
-(NSString *)objc_method {                                  \
  if (self.impl == NULL) abort();                           \
  const uint8_t *base = NULL;                               \
  size_t count = 0;                                         \
  cxx_func(self.impl, &base, &count);                       \
  if (base == NULL || count <= 0 || count > NSIntegerMax) { \
    abort();                                                \
  }                                                         \
  std::string str{(const char *)base, count};               \
  if (!mk::data::contains_valid_utf8(str)) {                \
    str = mk::data::base64_encode(std::move(str));          \
  }                                                         \
  return [NSString stringWithUTF8String:str.c_str()];       \
}

// MKUTIL_GET_STRING defines a getter returning string.
#define MKUTIL_GET_STRING(objc_method, cxx_func) \
-(NSString *)objc_method {                       \
  if (self.impl == NULL) abort();                \
  const char *s = cxx_func(self.impl);           \
  if (s == NULL) abort();                        \
  return [NSString stringWithUTF8String:s];      \
}

// MKUTIL_INIT_WITH_POINTER initializes a class with a pointer. This
// macro should not be used outside of the implementation file to avoid
// breaking the hiding of the internally used property.
#define MKUTIL_INIT_WITH_POINTER(cxx_type)          \
-(instancetype)initWithPointer:(cxx_type *)value {  \
  if (value == NULL) abort();                       \
  if ((self = [super init]) != nil) {               \
    self.impl = value;                              \
  }                                                 \
  return self;                                      \
}

// MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY defines an empty initialiser that
// implicitly sets the path of the bundled resources.
#define MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY(                              \
    cxx_ctor, cxx_ca_setter, cxx_asn_setter, cxx_country_setter)               \
-(instancetype)init {                                                          \
  if ((self = [super init]) != nil) {                                          \
    if ((self.impl = cxx_ctor()) == NULL) abort();                             \
    NSString *ca = [MKResources caBundlePath];                                 \
    NSString *asn = [MKResources mmdbASNPath];                                 \
    NSString *country = [MKResources mmdbCountryPath];                         \
    if (ca == nil || asn == nil || country == nil) {                           \
      abort();                                                                 \
    }                                                                          \
    cxx_ca_setter(self.impl, [ca UTF8String]);                                 \
    cxx_asn_setter(self.impl, [asn UTF8String]);                               \
    cxx_country_setter(self.impl, [country UTF8String]);                       \
  }                                                                            \
  return self;                                                                 \
}

// MKUTIL_SET_INT defines a setter for setting a int64_t value.
#define MKUTIL_SET_INT(objc_method, cxx_func) \
-(void)objc_method:(int64_t)value {           \
  if (self.impl == NULL) abort();             \
  cxx_func(self.impl, value);                 \
}

// MKUTIL_SET_STRING defines a setter for setting a string value.
#define MKUTIL_SET_STRING(objc_method, cxx_func) \
-(void)objc_method:(NSString *)value {           \
  if (value == nil) abort();                     \
  const char *s = [value UTF8String];            \
  if (s == NULL || self.impl == NULL) {          \
    abort();                                     \
  }                                              \
  cxx_func(self.impl, s);                        \
}

// MKUTIL_WRAP_GET_POINTER wraps the C++ method that obtains a pointer as the
// return value such that the pointer is wrapped by the proper ObjC class.
#define MKUTIL_WRAP_GET_POINTER(objc_return_type, objc_method, cxx_func) \
-(objc_return_type *)objc_method {                                       \
  auto p = cxx_func(self.impl);                                          \
  if (p == NULL) abort();                                                \
  return [[objc_return_type alloc] initWithPointer:p];                   \
}

#endif /* MKUtil_h */

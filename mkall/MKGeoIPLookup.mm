// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKGeoIPLookup.h"

#import "measurement_kit/internal/vendor/mkgeoip.hpp"

#import "MKUtil.hpp"

MKUTIL_EXTEND_CLASS(MKGeoIPLookupResults, mk::geoip::LookupResults)

@implementation MKGeoIPLookupResults

MKUTIL_INIT_WITH_POINTER(mk::geoip::LookupResults)

MKUTIL_GET_BOOL(good, [](auto response) noexcept {
  return response->good;
})

MKUTIL_GET_STRING(probeIP, [](auto response) noexcept {
  return response->probe_ip.c_str();
})

MKUTIL_GET_STRING(probeASN, [](auto response) noexcept {
  return response->probe_asn_string.c_str();
})

MKUTIL_GET_STRING(probeCC, [](auto response) noexcept {
  return response->probe_cc.c_str();
})

MKUTIL_GET_STRING(probeOrg, [](auto response) noexcept {
  return response->probe_org.c_str();
})

MKUTIL_GET_LOGS(logs, [](auto response) noexcept {
  return response->logs.size();
}, [](auto response, size_t idx) noexcept {
  return response->logs[idx].c_str();
})

MKUTIL_DEALLOC([](auto response) noexcept {
  delete response;
})

@end  // implementation MKGeoIPLookupResults

MKUTIL_EXTEND_CLASS(MKGeoIPLookupTask, mk::geoip::LookupSettings)

@implementation MKGeoIPLookupTask

MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY(
  []() noexcept { return new mk::geoip::LookupSettings{}; },
  [](auto settings, auto ca_bundle_path) noexcept {
    settings->ca_bundle_path = ca_bundle_path;
  },
  [](auto settings, auto asn_db_path) noexcept {
    settings->asn_db_path = asn_db_path;
  },
  [](auto settings, auto country_db_path) noexcept {
    settings->country_db_path = country_db_path;
  })

MKUTIL_SET_INT(setTimeout, [](auto settings, auto timeout) noexcept {
  settings->timeout = timeout;
})

MKUTIL_WRAP_GET_POINTER(MKGeoIPLookupResults, perform,
                        [](auto settings) noexcept {
  auto results = new mk::geoip::LookupResults{mk::geoip::lookup(*settings)};
  if (!results->good) {
    // Implementation note: the logic used by mk::geoip::lookup to determine
    // success checks the values of the probe_ip, probe_asn, etc fields. This
    // means we cannot initialize the results to the values we want to have
    // back on failure ("ZZ", "AS0", etc). We should instead check whether we
    // are good and set them afterwards. This glue code can probably go, if
    // we include this logic into the next release of mkgeoip.
    //
    // This code has been adapted from MK v0.10.4's geoiplookup.c. We should
    // actually fix geoiplookup to avoid duplicating code.
    //
    // Issue filed as <https://github.com/measurement-kit/mkgeoip/issues/18>.
    if (results->probe_asn_string.empty()) {
      results->probe_asn_string = "AS0";
    }
    if (results->probe_cc.empty()) {
      results->probe_cc = "ZZ";
    }
  }
  return results;
})

MKUTIL_DEALLOC([](auto settings) noexcept {
  delete settings;
})

@end  // implementation MKGeoIPLookupTask

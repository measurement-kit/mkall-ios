// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKGeoIPLookup.h"

#import "measurement_kit/internal/geoiplookup/geoiplookup.h"

#import "MKUtil.hpp"

MKUTIL_EXTEND_CLASS(MKGeoIPLookupResults, mk_geoiplookup_response_t)

@implementation MKGeoIPLookupResults

MKUTIL_INIT_WITH_POINTER(mk_geoiplookup_response_t)

MKUTIL_GET_BOOL(good, mk_geoiplookup_response_good)

MKUTIL_GET_STRING(probeIP, mk_geoiplookup_response_ip)

MKUTIL_GET_STRING(probeASN, mk_geoiplookup_response_asn)

MKUTIL_GET_STRING(probeCC, mk_geoiplookup_response_cc)

MKUTIL_GET_STRING(probeOrg, mk_geoiplookup_response_org)

MKUTIL_GET_LOGS(logs, mk_geoiplookup_response_logs_size,
                mk_geoiplookup_response_logs_at)

MKUTIL_DEINIT(mk_geoiplookup_response_delete)

@end  // implementation MKGeoIPLookupResults

MKUTIL_EXTEND_CLASS(MKGeoIPLookupSettings, mk_geoiplookup_request_t)

@implementation MKGeoIPLookupSettings

MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY(
  mk_geoiplookup_request_new,
  mk_geoiplookup_request_set_ca_bundle_path,
  mk_geoiplookup_request_set_asn_db_path,
  mk_geoiplookup_request_set_country_db_path)

MKUTIL_SET_INT(setTimeout, mk_geoiplookup_request_set_timeout)

MKUTIL_WRAP_GET_POINTER(MKGeoIPLookupResults, perform,
                        mk_geoiplookup_perform)

MKUTIL_DEINIT(mk_geoiplookup_request_delete)

@end  // implementation MKGeoIPLookupSettings

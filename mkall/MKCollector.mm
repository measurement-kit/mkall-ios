// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKCollector.h"

#import "MKResources.h"
#import "MKUtil.hpp"

#import "mkex-collector.h"

MKUTIL_EXTEND_CLASS(
  MKCollectorResubmitResults, mkex_collector_resubmit_response_t);

@implementation MKCollectorResubmitResults

MKUTIL_INIT_WITH_POINTER(mkex_collector_resubmit_response_t)

MKUTIL_GET_BOOL(good, mkex_collector_resubmit_response_good)

MKUTIL_GET_STRING(
  updatedSerializedMeasurement, mkex_collector_resubmit_response_content)

MKUTIL_GET_LOGS(logs, mkex_collector_resubmit_response_logs_size,
    mkex_collector_resubmit_response_logs_at)

MKUTIL_DEINIT(mkex_collector_resubmit_response_delete)

@end  // implementation MKCollectorResubmitResults

MKUTIL_EXTEND_CLASS(
  MKCollectorResubmitSettings, mkex_collector_resubmit_request_t);

@implementation MKCollectorResubmitSettings

MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY(
  mkex_collector_resubmit_request_new,
  mkex_collector_resubmit_request_set_ca_bundle_path,
  [](auto, auto) {}, [](auto, auto) {})

MKUTIL_SET_STRING(
  setSerializedMeasurement, mkex_collector_resubmit_request_set_content)

MKUTIL_SET_INT(setTimeout, mkex_collector_resubmit_request_set_timeout)

MKUTIL_WRAP_GET_POINTER(MKCollectorResubmitResults, perform,
                        mkex_collector_resubmit)

MKUTIL_DEINIT(mkex_collector_resubmit_request_delete)

@end // implementation MKCollectorResubmitSettings

// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#import "MKCollector.h"

#import "MKResources.h"
#import "MKUtil.hpp"

#import <measurement_kit/internal/collector/collector.h>

MKUTIL_EXTEND_CLASS(
  MKCollectorResubmitResults, mk_collector_resubmit_response_t);

@implementation MKCollectorResubmitResults

MKUTIL_INIT_WITH_POINTER(mk_collector_resubmit_response_t)

MKUTIL_GET_BOOL(good, mk_collector_resubmit_response_good)

MKUTIL_GET_STRING(
  updatedSerializedMeasurement, mk_collector_resubmit_response_content)

MKUTIL_GET_STRING(
  updatedReportID, mk_collector_resubmit_response_report_id)

MKUTIL_GET_LOGS(logs, mk_collector_resubmit_response_logs_size,
    mk_collector_resubmit_response_logs_at)

MKUTIL_DEINIT(mk_collector_resubmit_response_delete)

@end  // implementation MKCollectorResubmitResults

MKUTIL_EXTEND_CLASS(
  MKCollectorResubmitTask, mk_collector_resubmit_request_t);

@interface MKCollectorResubmitTask ()
-(instancetype)init;
@end // interface MKCollectorResubmitTask

@implementation MKCollectorResubmitTask

-(instancetype)initWithSerializedMeasurement:(NSString *)content
                                softwareName:(NSString *)softwareName
                             softwareVersion:(NSString *)softwareVersion {
  if ((self = [super init]) != nil) {
    [self setSerializedMeasurement:content];
    [self setSoftwareName:softwareName];
    [self setSoftwareVersion:softwareVersion];
  }
  return self;
}

MKUTIL_INIT_WITH_IMPLICIT_CA_ASN_COUNTRY(
  mk_collector_resubmit_request_new,
  mk_collector_resubmit_request_set_ca_bundle_path,
  [](auto, auto) {}, [](auto, auto) {})

MKUTIL_SET_STRING(
  setSerializedMeasurement, mk_collector_resubmit_request_set_content)

MKUTIL_SET_STRING(
  setSoftwareName, mk_collector_resubmit_request_set_software_name)

MKUTIL_SET_STRING(
  setSoftwareVersion, mk_collector_resubmit_request_set_software_version)

MKUTIL_SET_INT(setTimeout, mk_collector_resubmit_request_set_timeout)

MKUTIL_WRAP_GET_POINTER(MKCollectorResubmitResults, perform,
                        mk_collector_resubmit)

MKUTIL_DEINIT(mk_collector_resubmit_request_delete)

@end // implementation MKCollectorResubmitTask

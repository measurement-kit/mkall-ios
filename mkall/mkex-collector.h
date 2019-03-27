/* Part of Measurement Kit <https://measurement-kit.github.io/>.
   Measurement Kit is free software under the BSD license. See AUTHORS
   and LICENSE for more information on the copying conditions. */
#ifndef MEASUREMENT_KIT_COLLECTOR_COLLECTOR_H
#define MEASUREMENT_KIT_COLLECTOR_COLLECTOR_H

/** @file measurement_kit/internal/collector/collector.h
 *
 * @brief Internal FFI API to use OONI collector. Beware that internal APIs may
 * change radically at any new release of Measurement Kit.
 */

#include <stdint.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/** mkex_collector_settings_t contains common network related settings
 * used by all collector operations. */
typedef struct mkex_collector_settings mkex_collector_settings_t;

/** mkex_collector_settings_new creates new collector settings. It may return
 * NULL on failure. If the return value is non NULL, it is a pointer that
 * you own and must mkex_collector_settings_delete when done. */
mkex_collector_settings_t *mkex_collector_settings_new(void);

/** mkex_collector_settings_set_base_url sets the base URL to be used when
 * communicating with the collector. You typically discover this URL by
 * querying the OONI bouncer. This function will gracefully do nothing if
 * it is passed a NULL @p settings and/or @p value argument. */
void mkex_collector_settings_set_base_url(
    mkex_collector_settings_t *settings, const char *value);

/** mkex_collector_settings_set_ca_bundle_path sets the path to the CA bundle
 * to be used to validate TLS endpoints. This setting is optional on desktop
 * and requied on mobile. This function gracefully does nothing if the @p
 * settings and/or the @p value arguments are NULL pointers. */
void mkex_collector_settings_set_ca_bundle_path(
    mkex_collector_settings_t *settings, const char *value);

/** mkex_collector_settings_set_timeout sets the number of seconds after
 * which an outstanding, not completed HTTP request is aborted. A negative
 * or zero value disables the timeout. The default is a positive, but
 * otherwise unspecified, number of seconds. This function will do nothing
 * if the @p settings argument is a NULL pointer. */
void mkex_collector_settings_set_timeout(
    mkex_collector_settings_t *settings, int64_t timeout);

/** mkex_collector_settings_delete deletes @p settings. This function will
 * do nothing if @p settings is a NULL pointer. */
void mkex_collector_settings_delete(mkex_collector_settings_t *settings);

/** mkex_collector_open_request_t contains the settings required to open a
 * new report using the OONI collector. */
typedef struct mkex_collector_open_request mkex_collector_open_request_t;

/** mkex_collector_open_request_new creates a new open request. This function
 * may return NULL on failure. If the returned pointer is not NULL, you
 * own it and must mkex_collector_open_request_delete it when you are done. */
mkex_collector_open_request_t *mkex_collector_open_request_new(void);

/** mkex_collector_open_request_set_probe_asn sets the probe ASN. This value
 * is required. This function gracefully handles NULL input arguments. */
void mkex_collector_open_request_set_probe_asn(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_set_probe_cc sets the probe CC. This value
 * is required. This function gracefully handles NULL input arguments. */
void mkex_collector_open_request_set_probe_cc(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_set_software_name sets the software name. This
 * value is required. This function gracefully handles NULL input arguments. */
void mkex_collector_open_request_set_software_name(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_set_software_version sets the software version.
 * This value is required. This function gracefully handles NULL input
 * arguments. */
void mkex_collector_open_request_set_software_version(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_set_test_name sets the test name. This value
 * is required. This function gracefully handles NULL input arguments. */
void mkex_collector_open_request_set_test_name(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_set_test_start_time sets the test start time. This
 * value is required. It must be in UTC using the "%Y-%m-%d %H:%M:%S" format
 * string. This function gracefully handles NULL input arguments. */
void mkex_collector_open_request_set_test_start_time(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_set_test_version sets the test version. This value
 * is required. This function gracefully handles NULL input arguments. */
void mkex_collector_open_request_set_test_version(
    mkex_collector_open_request_t *request, const char *value);

/** mkex_collector_open_request_delete deletes @p request. This function will
 * do nothing if @p request is a NULL pointer. */
void mkex_collector_open_request_delete(mkex_collector_open_request_t *request);

/** mkex_collector_load_open_request_t contains the results of loading a
 * mkex_collector_open_request_t from a serialized JSON. You should use this
 * API when you want to submit an unsubmitted, serialized measurement. */
typedef struct mkex_collector_load_open_request mkex_collector_load_open_request_t;

/** mkex_collector_load_open_request_t loads an open request from the serialized
 * measurement JSON contained in @p measurement. This function may return a
 * NULL pointer on failure, including e.g. when @p measurement is NULL. If the
 * return value is not NULL, you own it and must dispose of it when you are
 * done using mkex_collector_load_open_request_delete. */
mkex_collector_load_open_request_t *mkex_collector_load_open_request(
    const char *measurement);

/** mkex_collector_load_open_request_good returns zero if loading failed
 * and nonzero if it succeded. In particular, it will always return zero
 * when the @p load argument is a NULL pointer. */
int64_t mkex_collector_load_open_request_good(
    const mkex_collector_load_open_request_t *load);

/** mkex_collector_load_open_request_reason returns the reason why we
 * failed to load an open request from a JSON. This function may return
 * NULL on failure, including the case where @p load is NULL. The
 * return value, if non NULL, is owned by @p load and has the same
 * lifecyle of @p load. When no error occurred and @p load is non NULL,
 * this function will return an empty string. */
const char *mkex_collector_load_open_request_reason(
    const mkex_collector_load_open_request_t *load);

/** mkex_collector_load_open_request_value returns the open request that has
 * been loaded from JSON. This function may return NULL on failure, for example
 * when the @p load argument is NULL. If the return value is not NULL, then it
 * is a pointer that you own and must mkex_collector_open_request_delete when you
 * are done with using it. Note that the returned pointer will be a copy of an
 * internally owned structure, with a different lifecycle from @p load. */
mkex_collector_open_request_t *mkex_collector_load_open_request_value(
    const mkex_collector_load_open_request_t *load);

/** mkex_collector_load_open_request_delete deletes @p load. This function will
 * do nothing if @p load is a NULL pointer. */
void mkex_collector_load_open_request_delete(
    mkex_collector_load_open_request_t *load);

/** mkex_collector_open_response_t contains the response to a request to open
 * a new report using the OONI collector. */
typedef struct mkex_collector_open_response mkex_collector_open_response_t;

/** mkex_collector_open_response_good returns zero if we failed to open a new
 * report and nonzero otherwise. This function will always return zero if the
 * @p response argument is a NULL pointer. */
int64_t mkex_collector_open_response_good(
    const mkex_collector_open_response_t *response);

/** mkex_collector_open_response_report_id returns the report ID. The returned
 * value may be NULL on failure, e.g. if @p response is NULL. Otherwise it is
 * a pointer owned by @p response and having the same lifecycle. Note that
 * the return value may be an empty string if we failed to open the report. */
const char *mkex_collector_open_response_report_id(
    const mkex_collector_open_response_t *response);

/** mkex_collector_open_response_logs_size returns the number of log entries
 * contained by @p response. This number will always be zero in case the
 * provided @p response argument is a NULL pointer. */
size_t mkex_collector_open_response_logs_size(
    const mkex_collector_open_response_t *response);

/** mkex_collector_open_response_logs_at returns the specific log entry at
 * index @p idx contained in @p response. This function will return a NULL
 * pointer if @p response is NULL and/or @p idx is out of bounds. Otherwise,
 * the returned string is owned by @p response and has the same lifecycle
 * of @p response. We guarantee that the returned string is either valid
 * UTF-8 or the base64 encoding of a non UTF-8 string. */
const char *mkex_collector_open_response_logs_at(
    const mkex_collector_open_response_t *response, size_t idx);

/** mkex_collector_open_response_delete deletes @p response. This function
 * will gracefully do nothing if @p response is a NULL pointer. */
void mkex_collector_open_response_delete(
    mkex_collector_open_response_t *response);

/** mkex_collector_open attempts to open a new report with a OONI collector
 * using the provided @p request and @p settings. This function may return
 * NULL on failure, including the case where the input arguments are NULL
 * pointers. You own the returned value, if not NULL, and must delete it
 * using mkex_collector_open_response_delete when done using it. */
mkex_collector_open_response_t *mkex_collector_open(
    const mkex_collector_open_request_t *request,
    const mkex_collector_settings_t *settings);

/** mkex_collector_update_request_t is a request to update a OONI report
 * by adding the results of a measurement to it. */
typedef struct mkex_collector_update_request mkex_collector_update_request_t;

/** mkex_collector_update_request_new creates a new update report request. The
 * return value may be NULL on failure. If not NULL, is a pointer that you
 * own and must mkex_collector_update_request_delete when done. */
mkex_collector_update_request_t *mkex_collector_update_request_new(void);

/** mkex_collector_update_request_set_report_id sets the report ID, which you
 * have learned when opening the report. This function will behave gracefully
 * if either @p request or @p value are NULL pointers. */
void mkex_collector_update_request_set_report_id(
    mkex_collector_update_request_t *request, const char *value);

/** mkex_collector_update_request_set_content sets the measurement entry to
 * be added to the report. This must of course be a valid JSON. This function
 * behaves gracefully if passed NULL pointer arguments. */
void mkex_collector_update_request_set_content(
    mkex_collector_update_request_t *request, const char *value);

/** mkex_collector_update_request_delete deletes @p request. If @p request
 * is a NULL pointer, this function will just do nothing. */
void mkex_collector_update_request_delete(
    mkex_collector_update_request_t *request);

/** mkex_collector_update_response_t contains the response to a request to update
 * an existing report using the OONI collector. */
typedef struct mkex_collector_update_response mkex_collector_update_response_t;

/** mkex_collector_update_response_good returns zero if we failed to update a new
 * report and nonzero otherwise. This function will always return zero if the
 * @p response argument is a NULL pointer. */
int64_t mkex_collector_update_response_good(
    const mkex_collector_update_response_t *response);

/** mkex_collector_update_response_logs_size returns the number of log entries
 * contained by @p response. This number will always be zero in case the
 * provided @p response argument is a NULL pointer. */
size_t mkex_collector_update_response_logs_size(
    const mkex_collector_update_response_t *response);

/** mkex_collector_update_response_logs_at returns the specific log entry at
 * index @p idx contained in @p response. This function will return a NULL
 * pointer if @p response is NULL and/or @p idx is out of bounds. Otherwise,
 * the returned string is owned by @p response and has the same lifecycle
 * of @p response. We guarantee that the returned string is either valid
 * UTF-8 or the base64 encoding of a non UTF-8 string. */
const char *mkex_collector_update_response_logs_at(
    const mkex_collector_update_response_t *response, size_t idx);

/** mkex_collector_update_response_delete deletes @p response. This function
 * will gracefully do nothing if @p response is a NULL pointer. */
void mkex_collector_update_response_delete(
    mkex_collector_update_response_t *response);

/** mkex_collector_update attempts to update a report with a OONI collector
 * using the provided @p request and @p settings. This function may return
 * NULL on failure, including the case where the input arguments are NULL
 * pointers. You own the returned value, if not NULL, and must delete it
 * using mkex_collector_update_response_delete when done using it. */
mkex_collector_update_response_t *mkex_collector_update(
    const mkex_collector_update_request_t *request,
    const mkex_collector_settings_t *settings);

/** mkex_collector_close_request_t is a request to close a OONI report. */
typedef struct mkex_collector_close_request mkex_collector_close_request_t;

/** mkex_collector_close_request_new creates a new close report request. The
 * return value may be NULL on failure. If not NULL, is a pointer that you
 * own and must mkex_collector_close_request_delete when done. */
mkex_collector_close_request_t *mkex_collector_close_request_new(void);

/** mkex_collector_close_request_set_report_id sets the report ID, which you
 * have learned when opening the report. This function will behave gracefully
 * if either @p request or @p value are NULL pointers. */
void mkex_collector_close_request_set_report_id(
    mkex_collector_close_request_t *request, const char *value);

/** mkex_collector_close_request_delete deletes @p request. If @p request
 * is a NULL pointer, this function will just do nothing. */
void mkex_collector_close_request_delete(
    mkex_collector_close_request_t *request);

/** mkex_collector_close_response_t contains the response to a request to close
 * an existing report using the OONI collector. */
typedef struct mkex_collector_close_response mkex_collector_close_response_t;

/** mkex_collector_close_response_good returns zero if we failed to close a new
 * report and nonzero otherwise. This function will always return zero if the
 * @p response argument is a NULL pointer. */
int64_t mkex_collector_close_response_good(
    const mkex_collector_close_response_t *response);

/** mkex_collector_close_response_logs_size returns the number of log entries
 * contained by @p response. This number will always be zero in case the
 * provided @p response argument is a NULL pointer. */
size_t mkex_collector_close_response_logs_size(
    const mkex_collector_close_response_t *response);

/** mkex_collector_close_response_logs_at returns the specific log entry at
 * index @p idx contained in @p response. This function will return a NULL
 * pointer if @p response is NULL and/or @p idx is out of bounds. Otherwise,
 * the returned string is owned by @p response and has the same lifecycle
 * of @p response. We guarantee that the returned string is either valid
 * UTF-8 or the base64 encoding of a non UTF-8 string. */
const char *mkex_collector_close_response_logs_at(
    const mkex_collector_close_response_t *response, size_t idx);

/** mkex_collector_close_response_delete deletes @p response. This function
 * will gracefully do nothing if @p response is a NULL pointer. */
void mkex_collector_close_response_delete(
    mkex_collector_close_response_t *response);

/** mkex_collector_close attempts to close a report with a OONI collector
 * using the provided @p request and @p settings. This function may return
 * NULL on failure, including the case where the input arguments are NULL
 * pointers. You own the returned value, if not NULL, and must delete it
 * using mkex_collector_close_response_delete when done using it. */
mkex_collector_close_response_t *mkex_collector_close(
    const mkex_collector_close_request_t *request,
    const mkex_collector_settings_t *settings);

/** mkex_collector_resubmit_request_t is a request to resubmit a measurement. */
typedef struct mkex_collector_resubmit_request mkex_collector_resubmit_request_t;

/** mkex_collector_resubmit_request_new creates a new resubmit measurement
 * request. The return value may be NULL on failure. If not NULL, is a pointer
 * that you own and must mkex_collector_resubmit_request_delete when done. */
mkex_collector_resubmit_request_t *mkex_collector_resubmit_request_new(void);

/** mkex_collector_resubmit_request_set_content sets the measurement entry to
 * be added to the report. This must of course be a valid JSON. This function
 * behaves gracefully if passed NULL pointer arguments. */
void mkex_collector_resubmit_request_set_content(
    mkex_collector_resubmit_request_t *request, const char *value);

/** mkex_collector_resubmit_request_set_ca_bundle_path sets the path to the CA
 * bundle to be used to validate TLS endpoints. This setting is optional on
 * desktop and requied on mobile. This function gracefully does nothing if the
 * @p settings and/or the @p value arguments are NULL pointers. */
void mkex_collector_resubmit_request_set_ca_bundle_path(
    mkex_collector_resubmit_request_t *request, const char *value);

/** mkex_collector_resubmit_request_set_timeout sets the number of seconds after
 * which an outstanding, not completed HTTP request is aborted. A negative
 * or zero value disables the timeout. The default is a positive, but
 * otherwise unspecified, number of seconds. This function will do nothing
 * if the @p request argument is a NULL pointer. */
void mkex_collector_resubmit_request_set_timeout(
    mkex_collector_resubmit_request_t *request, int64_t timeout);

/** mkex_collector_resubmit_request_delete deletes @p request. This function
 * will gracefully do nothing if @p request is a NULL pointer. */
void mkex_collector_resubmit_request_delete(
    mkex_collector_resubmit_request_t *request);

/** mkex_collector_resubmit_response_t contains the response to a request to
 * resubmit a measurement using the OONI collector. */
typedef struct mkex_collector_resubmit_response mkex_collector_resubmit_response_t;

/** mkex_collector_resubmit_response_good returns zero if we failed to resubmit
 * and nonzero otherwise. This function will always return zero if the
 * @p response argument is a NULL pointer. */
int64_t mkex_collector_resubmit_response_good(
    const mkex_collector_resubmit_response_t *response);

/** mkex_collector_resubmit_response_report_id returns the report ID. The returned
 * value may be NULL on failure, e.g. if @p response is NULL. Otherwise it is
 * a pointer owned by @p response and having the same lifecycle. Note that
 * the return value may be an empty string if we failed to resubmit. */
const char *mkex_collector_resubmit_response_report_id(
    const mkex_collector_resubmit_response_t *response);

/** mkex_collector_resubmit_response_content returns the updated measurement
 * content. Specifically, the measurement has been updated with the correct
 * report ID. The returned value may be NULL on failure, e.g. if @p
 * response is NULL. Otherwise it is a pointer owned by @p response and having
 * the same lifecycle. Note that the return value may be an empty string if
 * we fail early in the resubmission. */
const char *mkex_collector_resubmit_response_content(
    const mkex_collector_resubmit_response_t *response);

/** mkex_collector_resubmit_response_logs_size returns the number of log entries
 * contained by @p response. This number will always be zero in case the
 * provided @p response argument is a NULL pointer. */
size_t mkex_collector_resubmit_response_logs_size(
    const mkex_collector_resubmit_response_t *response);

/** mkex_collector_resubmit_response_logs_at returns the specific log entry at
 * index @p idx contained in @p response. This function will return a NULL
 * pointer if @p response is NULL and/or @p idx is out of bounds. Otherwise,
 * the returned string is owned by @p response and has the same lifecycle
 * of @p response. We guarantee that the returned string is either valid
 * UTF-8 or the base64 encoding of a non UTF-8 string. */
const char *mkex_collector_resubmit_response_logs_at(
    const mkex_collector_resubmit_response_t *response, size_t idx);

/** mkex_collector_resubmit_response_delete deletes @p response. This function
 * will gracefully do nothing if @p response is a NULL pointer. */
void mkex_collector_resubmit_response_delete(
    mkex_collector_resubmit_response_t *response);

/** mkex_collector_resubmit attempts to resubmit a report with a OONI collector
 * using the provided @p request and @p settings. This function may return
 * NULL on failure, including the case where the input arguments are NULL
 * pointers. You own the returned value, if not NULL, and must delete it
 * using mkex_collector_resubmit_response_delete when done using it. */
mkex_collector_resubmit_response_t *mkex_collector_resubmit(
    const mkex_collector_resubmit_request_t *request);

#ifdef __cplusplus
}
#endif  /* __cplusplus */
#endif  /* MEASUREMENT_KIT_COLLECTOR_COLLECTOR_H */

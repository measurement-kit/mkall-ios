// Part of Measurement Kit <https://measurement-kit.github.io/>.
// Measurement Kit is free software under the BSD license. See AUTHORS
// and LICENSE for more information on the copying conditions.

#include "mkex-collector.h"

#include <stdint.h>
#include <stdlib.h>

#include <string>
#include <vector>

#include <measurement_kit/internal/vendor/json.hpp>
#include <measurement_kit/internal/vendor/mkbouncer.hpp>
#include <measurement_kit/internal/vendor/mkcollector.hpp>
#include <measurement_kit/internal/vendor/mkdata.hpp>

struct mkex_collector_settings {
  mk::collector::Settings s;
};

mkex_collector_settings_t *mkex_collector_settings_new() {
  return new mkex_collector_settings_t;
}

void mkex_collector_settings_set_base_url(
    mkex_collector_settings_t *settings, const char *value) {
  if (settings && value) settings->s.base_url = value;
}

void mkex_collector_settings_set_ca_bundle_path(
    mkex_collector_settings_t *settings, const char *value) {
  if (settings && value) settings->s.ca_bundle_path = value;
}

void mkex_collector_settings_set_timeout(
    mkex_collector_settings_t *settings, int64_t timeout) {
  if (settings) settings->s.timeout = timeout;
}

void mkex_collector_settings_delete(mkex_collector_settings_t *settings) {
  delete settings;
}

struct mkex_collector_open_request {
  mk::collector::OpenRequest r;
};

mkex_collector_open_request_t *mkex_collector_open_request_new() {
  return new mkex_collector_open_request_t;
}

void mkex_collector_open_request_set_probe_asn(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.probe_asn = value;
}

void mkex_collector_open_request_set_probe_cc(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.probe_cc = value;
}

void mkex_collector_open_request_set_software_name(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.software_name = value;
}

void mkex_collector_open_request_set_software_version(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.software_version = value;
}

void mkex_collector_open_request_set_test_name(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.test_name = value;
}

void mkex_collector_open_request_set_test_start_time(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.test_start_time = value;
}

void mkex_collector_open_request_set_test_version(
    mkex_collector_open_request_t *request, const char *value) {
  if (request && value) request->r.test_version = value;
}

void mkex_collector_open_request_delete(mkex_collector_open_request_t *request) {
  delete request;
}

struct mkex_collector_load_open_request {
  mk::collector::LoadResult<mk::collector::OpenRequest> m;
};

mkex_collector_load_open_request_t *mkex_collector_load_open_request(
    const char *measurement) {
  if (measurement == nullptr) return nullptr;
  auto load = new mkex_collector_load_open_request_t;
  load->m = mk::collector::open_request_from_measurement(measurement);
  return load;
}

int64_t mkex_collector_load_open_request_good(
    const mkex_collector_load_open_request_t *load) {
  return (load) ? load->m.good : false;
}

const char *mkex_collector_load_open_request_reason(
    const mkex_collector_load_open_request_t *load) {
  return (load) ? load->m.reason.c_str() : nullptr;
}

mkex_collector_open_request_t *mkex_collector_load_open_request_value(
    const mkex_collector_load_open_request_t *load) {
  if (!load) return nullptr;
  auto request = new mkex_collector_open_request_t;
  request->r = load->m.value;
  return request;
}

void mkex_collector_load_open_request_delete(
    mkex_collector_load_open_request_t *load) {
  delete load;
}

struct mkex_collector_open_response {
  mk::collector::OpenResponse r;
};

int64_t mkex_collector_open_response_good(
    const mkex_collector_open_response_t *response) {
  return (response) ? response->r.good : false;
}

const char *mkex_collector_open_response_report_id(
    const mkex_collector_open_response_t *response) {
  return (response) ? response->r.report_id.c_str() : nullptr;
}

size_t mkex_collector_open_response_logs_size(
    const mkex_collector_open_response_t *response) {
  return (response) ? response->r.logs.size() : 0;
}

const char *mkex_collector_open_response_logs_at(
    const mkex_collector_open_response_t *response, size_t idx) {
  return (response && idx < response->r.logs.size()) ?
      response->r.logs[idx].c_str() : nullptr;
}

void mkex_collector_open_response_delete(
    mkex_collector_open_response_t *response) {
  delete response;
}

static void sanitize_logs(std::vector<std::string> &logs) noexcept {
  for (auto &s : logs) {
    if (!mk::data::contains_valid_utf8(s)) {
      s = mk::data::base64_encode(std::move(s));
    }
  }
}

mkex_collector_open_response_t *mkex_collector_open(
    const mkex_collector_open_request_t *request,
    const mkex_collector_settings_t *settings) {
  if (!request || !settings) return nullptr;
  auto response = new mkex_collector_open_response_t;
  response->r = mk::collector::open(request->r, settings->s);
  sanitize_logs(response->r.logs);
  return response;
}

struct mkex_collector_update_request {
  mk::collector::UpdateRequest r;
};

mkex_collector_update_request_t *mkex_collector_update_request_new() {
  return new mkex_collector_update_request_t;
}

void mkex_collector_update_request_set_report_id(
    mkex_collector_update_request_t *request, const char *value) {
  if (request && value) request->r.report_id = value;
}

void mkex_collector_update_request_set_content(
    mkex_collector_update_request_t *request, const char *value) {
  if (request && value) request->r.content = value;
}

void mkex_collector_update_request_delete(
    mkex_collector_update_request_t *request) {
  delete request;
}

struct mkex_collector_update_response {
  mk::collector::UpdateResponse r;
};

int64_t mkex_collector_update_response_good(
    const mkex_collector_update_response_t *response) {
  return (response) ? response->r.good : false;
}

size_t mkex_collector_update_response_logs_size(
    const mkex_collector_update_response_t *response) {
  return (response) ? response->r.logs.size() : 0;
}

const char *mkex_collector_update_response_logs_at(
    const mkex_collector_update_response_t *response, size_t idx) {
  return (response && idx < response->r.logs.size()) ?
    response->r.logs[idx].c_str() : nullptr;
}

void mkex_collector_update_response_delete(
    mkex_collector_update_response_t *response) {
  delete response;
}

mkex_collector_update_response_t *mkex_collector_update(
    const mkex_collector_update_request_t *request,
    const mkex_collector_settings_t *settings) {
  if (!request || !settings) return nullptr;
  auto response = new mkex_collector_update_response_t;
  response->r = mk::collector::update(request->r, settings->s);
  sanitize_logs(response->r.logs);
  return response;
}

struct mkex_collector_close_request {
  mk::collector::CloseRequest r;
};

mkex_collector_close_request_t *mkex_collector_close_request_new() {
  return new mkex_collector_close_request_t;
}

void mkex_collector_close_request_set_report_id(
    mkex_collector_close_request_t *request, const char *value) {
  if (request && value) request->r.report_id = value;
}

void mkex_collector_close_request_delete(
    mkex_collector_close_request_t *request) {
  delete request;
}

struct mkex_collector_close_response {
  mk::collector::CloseResponse r;
};

int64_t mkex_collector_close_response_good(
    const mkex_collector_close_response_t *response) {
  return (response) ? response->r.good : false;
}

size_t mkex_collector_close_response_logs_size(
    const mkex_collector_close_response_t *response) {
  return (response) ? response->r.logs.size() : 0;
}

const char *mkex_collector_close_response_logs_at(
    const mkex_collector_close_response_t *response, size_t idx) {
  return (response && idx < response->r.logs.size()) ?
    response->r.logs[idx].c_str() : nullptr;
}

void mkex_collector_close_response_delete(
    mkex_collector_close_response_t *response) {
  delete response;
}

mkex_collector_close_response_t *mkex_collector_close(
    const mkex_collector_close_request_t *request,
    const mkex_collector_settings_t *settings) {
  if (!request || !settings) return nullptr;
  auto response = new mkex_collector_close_response_t;
  response->r = mk::collector::close(request->r, settings->s);
  sanitize_logs(response->r.logs);
  return response;
}

struct mkex_collector_resubmit_request {
  std::string content;
  mk::collector::Settings settings;
};

mkex_collector_resubmit_request_t *mkex_collector_resubmit_request_new() {
  return new mkex_collector_resubmit_request_t;
}

void mkex_collector_resubmit_request_set_content(
    mkex_collector_resubmit_request_t *request, const char *value) {
  if (request && value) request->content = value;
}

void mkex_collector_resubmit_request_set_ca_bundle_path(
    mkex_collector_resubmit_request_t *request, const char *value) {
  if (request && value) request->settings.ca_bundle_path = value;
}

void mkex_collector_resubmit_request_set_timeout(
    mkex_collector_resubmit_request_t *request, int64_t timeout) {
  if (request) request->settings.timeout = timeout;
}

void mkex_collector_resubmit_request_delete(
    mkex_collector_resubmit_request_t *request) {
  delete request;
}

struct mkex_collector_resubmit_response {
  int64_t good = false;
  std::string report_id;
  std::string content;
  std::vector<std::string> logs;
};

int64_t mkex_collector_resubmit_response_good(
    const mkex_collector_resubmit_response_t *response) {
  return (response) ? response->good : false;
}

const char *mkex_collector_resubmit_response_report_id(
    const mkex_collector_resubmit_response_t *response) {
  return (response) ? response->report_id.c_str() : nullptr;
}

const char *mkex_collector_resubmit_response_content(
    const mkex_collector_resubmit_response_t *response) {
  return (response) ? response->content.c_str() : nullptr;
}

size_t mkex_collector_resubmit_response_logs_size(
    const mkex_collector_resubmit_response_t *response) {
  return (response) ? response->logs.size() : 0;
}

const char *mkex_collector_resubmit_response_logs_at(
    const mkex_collector_resubmit_response_t *response, size_t idx) {
  return (response && idx < response->logs.size()) ?
      response->logs[idx].c_str() : nullptr;
}

void mkex_collector_resubmit_response_delete(
    mkex_collector_resubmit_response_t *response) {
  delete response;
}

// mkex_collector_maybe_guess_url_ guesses the URL in @p settings if that
// is not already set by the user code that called us.
//
// TODO(bassosimone): more collector APIs could use this function.
static void mkex_collector_maybe_guess_url_(
    mk::collector::Settings &settings,
    std::vector<std::string> &logs) noexcept {
  if (settings.base_url != "") {
    return;
  }
  mk::bouncer::Request bouncer_request;
  bouncer_request.ca_bundle_path = settings.ca_bundle_path;
  bouncer_request.timeout = settings.timeout;
  bouncer_request.name = "measurement-kit-report-resubmitter";
  bouncer_request.version = "0.0.1";
  auto bouncer_response = mk::bouncer::perform(bouncer_request);
  logs.insert(logs.end(), bouncer_response.logs.begin(),
              bouncer_response.logs.end());
  for (auto &record : bouncer_response.collectors) {
    if (record.type == "https") {
      settings.base_url = record.address;
      break;
    }
  }
  if (settings.base_url == "") {
    logs.push_back("No collector found; using b.collector.ooni.io");
    settings.base_url = "https://b.collector.ooni.io";
  }
}

// TODO(bassosimone): this functionality should probably be moved inside
// of the mkcollector sub-library. It does not belong here.
static mkex_collector_resubmit_response_t *mkex_collector_resubmit_(
    const mkex_collector_resubmit_request_t *request) noexcept {
  if (!request) return nullptr;
  std::unique_ptr<mkex_collector_resubmit_response_t> response{
    new mkex_collector_resubmit_response_t
  };
  auto load_result = mk::collector::open_request_from_measurement(
      request->content);
  if (!load_result.good) {
    response->logs.push_back(std::move(load_result.reason));
    return response.release();
  }
  mk::collector::Settings settings = request->settings;
  mkex_collector_maybe_guess_url_(settings, response->logs);
  auto open_response = mk::collector::open(load_result.value, settings);
  response->logs.insert(response->logs.end(), open_response.logs.begin(),
                        open_response.logs.end());
  if (!open_response.good) {
    return response.release();
  }
  std::swap(response->report_id, open_response.report_id);
  try {
    nlohmann::json doc = nlohmann::json::parse(request->content);
    doc["report_id"] = response->report_id;
    response->content = doc.dump();
  } catch (const std::exception &exc) {
    response->logs.push_back(exc.what());
    return response.release();
  }
  mk::collector::UpdateRequest update_request;
  update_request.report_id = response->report_id;
  update_request.content = response->content;
  auto update_response = mk::collector::update(update_request, settings);
  response->logs.insert(response->logs.end(), update_response.logs.begin(),
                        update_response.logs.end());
  if (!update_response.good) {
    return response.release();
  }
  mk::collector::CloseRequest close_request;
  close_request.report_id = response->report_id;
  auto close_response = mk::collector::close(close_request, settings);
  response->logs.insert(response->logs.end(), close_response.logs.begin(),
                        close_response.logs.end());
  // We don't care if we cannot clse the report. At this point we have
  // submitted, therefore, tell the app that it's all good.
  response->good = true;
  return response.release();
}

mkex_collector_resubmit_response_t *mkex_collector_resubmit(
    const mkex_collector_resubmit_request_t *request) {
  auto response = mkex_collector_resubmit_(request);
  if (response != nullptr) {
    sanitize_logs(response->logs);
  }
  return response;
}

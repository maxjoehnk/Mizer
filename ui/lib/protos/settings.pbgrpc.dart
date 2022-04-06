///
//  Generated code. Do not modify.
//  source: settings.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'settings.pb.dart' as $0;
export 'settings.pb.dart';

class SettingsApiClient extends $grpc.Client {
  static final _$loadSettings =
      $grpc.ClientMethod<$0.RequestSettings, $0.Settings>(
          '/mizer.settings.SettingsApi/LoadSettings',
          ($0.RequestSettings value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Settings.fromBuffer(value));
  static final _$saveSettings = $grpc.ClientMethod<$0.Settings, $0.Settings>(
      '/mizer.settings.SettingsApi/SaveSettings',
      ($0.Settings value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Settings.fromBuffer(value));

  SettingsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Settings> loadSettings($0.RequestSettings request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$loadSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.Settings> saveSettings($0.Settings request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveSettings, request, options: options);
  }
}

abstract class SettingsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.settings.SettingsApi';

  SettingsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestSettings, $0.Settings>(
        'LoadSettings',
        loadSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestSettings.fromBuffer(value),
        ($0.Settings value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Settings, $0.Settings>(
        'SaveSettings',
        saveSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Settings.fromBuffer(value),
        ($0.Settings value) => value.writeToBuffer()));
  }

  $async.Future<$0.Settings> loadSettings_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RequestSettings> request) async {
    return loadSettings(call, await request);
  }

  $async.Future<$0.Settings> saveSettings_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Settings> request) async {
    return saveSettings(call, await request);
  }

  $async.Future<$0.Settings> loadSettings(
      $grpc.ServiceCall call, $0.RequestSettings request);
  $async.Future<$0.Settings> saveSettings(
      $grpc.ServiceCall call, $0.Settings request);
}

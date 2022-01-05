///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'connections.pb.dart' as $0;
export 'connections.pb.dart';

class ConnectionsApiClient extends $grpc.Client {
  static final _$getConnections =
      $grpc.ClientMethod<$0.GetConnectionsRequest, $0.Connections>(
          '/mizer.ConnectionsApi/GetConnections',
          ($0.GetConnectionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Connections.fromBuffer(value));
  static final _$monitorDmx =
      $grpc.ClientMethod<$0.MonitorDmxRequest, $0.MonitorDmxResponse>(
          '/mizer.ConnectionsApi/MonitorDmx',
          ($0.MonitorDmxRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MonitorDmxResponse.fromBuffer(value));
  static final _$monitorMidi =
      $grpc.ClientMethod<$0.MonitorMidiRequest, $0.MonitorMidiResponse>(
          '/mizer.ConnectionsApi/MonitorMidi',
          ($0.MonitorMidiRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MonitorMidiResponse.fromBuffer(value));
  static final _$addArtnetConnection =
      $grpc.ClientMethod<$0.AddArtnetRequest, $0.Connections>(
          '/mizer.ConnectionsApi/AddArtnetConnection',
          ($0.AddArtnetRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Connections.fromBuffer(value));
  static final _$addSacnConnection =
      $grpc.ClientMethod<$0.AddSacnRequest, $0.Connections>(
          '/mizer.ConnectionsApi/AddSacnConnection',
          ($0.AddSacnRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Connections.fromBuffer(value));
  static final _$getMidiDeviceProfiles =
      $grpc.ClientMethod<$0.GetDeviceProfilesRequest, $0.MidiDeviceProfiles>(
          '/mizer.ConnectionsApi/GetMidiDeviceProfiles',
          ($0.GetDeviceProfilesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MidiDeviceProfiles.fromBuffer(value));

  ConnectionsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Connections> getConnections(
      $0.GetConnectionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConnections, request, options: options);
  }

  $grpc.ResponseFuture<$0.MonitorDmxResponse> monitorDmx(
      $0.MonitorDmxRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$monitorDmx, request, options: options);
  }

  $grpc.ResponseStream<$0.MonitorMidiResponse> monitorMidi(
      $0.MonitorMidiRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$monitorMidi, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Connections> addArtnetConnection(
      $0.AddArtnetRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addArtnetConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.Connections> addSacnConnection(
      $0.AddSacnRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addSacnConnection, request, options: options);
  }

  $grpc.ResponseFuture<$0.MidiDeviceProfiles> getMidiDeviceProfiles(
      $0.GetDeviceProfilesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMidiDeviceProfiles, request, options: options);
  }
}

abstract class ConnectionsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.ConnectionsApi';

  ConnectionsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetConnectionsRequest, $0.Connections>(
        'GetConnections',
        getConnections_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetConnectionsRequest.fromBuffer(value),
        ($0.Connections value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MonitorDmxRequest, $0.MonitorDmxResponse>(
        'MonitorDmx',
        monitorDmx_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MonitorDmxRequest.fromBuffer(value),
        ($0.MonitorDmxResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.MonitorMidiRequest, $0.MonitorMidiResponse>(
            'MonitorMidi',
            monitorMidi_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.MonitorMidiRequest.fromBuffer(value),
            ($0.MonitorMidiResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddArtnetRequest, $0.Connections>(
        'AddArtnetConnection',
        addArtnetConnection_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddArtnetRequest.fromBuffer(value),
        ($0.Connections value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddSacnRequest, $0.Connections>(
        'AddSacnConnection',
        addSacnConnection_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddSacnRequest.fromBuffer(value),
        ($0.Connections value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetDeviceProfilesRequest, $0.MidiDeviceProfiles>(
            'GetMidiDeviceProfiles',
            getMidiDeviceProfiles_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetDeviceProfilesRequest.fromBuffer(value),
            ($0.MidiDeviceProfiles value) => value.writeToBuffer()));
  }

  $async.Future<$0.Connections> getConnections_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetConnectionsRequest> request) async {
    return getConnections(call, await request);
  }

  $async.Future<$0.MonitorDmxResponse> monitorDmx_Pre($grpc.ServiceCall call,
      $async.Future<$0.MonitorDmxRequest> request) async {
    return monitorDmx(call, await request);
  }

  $async.Stream<$0.MonitorMidiResponse> monitorMidi_Pre($grpc.ServiceCall call,
      $async.Future<$0.MonitorMidiRequest> request) async* {
    yield* monitorMidi(call, await request);
  }

  $async.Future<$0.Connections> addArtnetConnection_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddArtnetRequest> request) async {
    return addArtnetConnection(call, await request);
  }

  $async.Future<$0.Connections> addSacnConnection_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AddSacnRequest> request) async {
    return addSacnConnection(call, await request);
  }

  $async.Future<$0.MidiDeviceProfiles> getMidiDeviceProfiles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDeviceProfilesRequest> request) async {
    return getMidiDeviceProfiles(call, await request);
  }

  $async.Future<$0.Connections> getConnections(
      $grpc.ServiceCall call, $0.GetConnectionsRequest request);
  $async.Future<$0.MonitorDmxResponse> monitorDmx(
      $grpc.ServiceCall call, $0.MonitorDmxRequest request);
  $async.Stream<$0.MonitorMidiResponse> monitorMidi(
      $grpc.ServiceCall call, $0.MonitorMidiRequest request);
  $async.Future<$0.Connections> addArtnetConnection(
      $grpc.ServiceCall call, $0.AddArtnetRequest request);
  $async.Future<$0.Connections> addSacnConnection(
      $grpc.ServiceCall call, $0.AddSacnRequest request);
  $async.Future<$0.MidiDeviceProfiles> getMidiDeviceProfiles(
      $grpc.ServiceCall call, $0.GetDeviceProfilesRequest request);
}

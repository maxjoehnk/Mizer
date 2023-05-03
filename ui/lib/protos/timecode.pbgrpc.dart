///
//  Generated code. Do not modify.
//  source: timecode.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'timecode.pb.dart' as $0;
export 'timecode.pb.dart';

class TimecodeApiClient extends $grpc.Client {
  static final _$addTimecode =
      $grpc.ClientMethod<$0.AddTimecodeRequest, $0.NoContentResponse>(
          '/mizer.timecode.TimecodeApi/AddTimecode',
          ($0.AddTimecodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NoContentResponse.fromBuffer(value));
  static final _$renameTimecode =
      $grpc.ClientMethod<$0.RenameTimecodeRequest, $0.NoContentResponse>(
          '/mizer.timecode.TimecodeApi/RenameTimecode',
          ($0.RenameTimecodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NoContentResponse.fromBuffer(value));
  static final _$deleteTimecode =
      $grpc.ClientMethod<$0.DeleteTimecodeRequest, $0.NoContentResponse>(
          '/mizer.timecode.TimecodeApi/DeleteTimecode',
          ($0.DeleteTimecodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NoContentResponse.fromBuffer(value));
  static final _$addTimecodeControl =
      $grpc.ClientMethod<$0.AddTimecodeControlRequest, $0.NoContentResponse>(
          '/mizer.timecode.TimecodeApi/AddTimecodeControl',
          ($0.AddTimecodeControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NoContentResponse.fromBuffer(value));
  static final _$renameTimecodeControl =
      $grpc.ClientMethod<$0.RenameTimecodeControlRequest, $0.NoContentResponse>(
          '/mizer.timecode.TimecodeApi/RenameTimecodeControl',
          ($0.RenameTimecodeControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NoContentResponse.fromBuffer(value));
  static final _$deleteTimecodeControl =
      $grpc.ClientMethod<$0.DeleteTimecodeControlRequest, $0.NoContentResponse>(
          '/mizer.timecode.TimecodeApi/DeleteTimecodeControl',
          ($0.DeleteTimecodeControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.NoContentResponse.fromBuffer(value));

  TimecodeApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.NoContentResponse> addTimecode(
      $0.AddTimecodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTimecode, request, options: options);
  }

  $grpc.ResponseFuture<$0.NoContentResponse> renameTimecode(
      $0.RenameTimecodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameTimecode, request, options: options);
  }

  $grpc.ResponseFuture<$0.NoContentResponse> deleteTimecode(
      $0.DeleteTimecodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTimecode, request, options: options);
  }

  $grpc.ResponseFuture<$0.NoContentResponse> addTimecodeControl(
      $0.AddTimecodeControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addTimecodeControl, request, options: options);
  }

  $grpc.ResponseFuture<$0.NoContentResponse> renameTimecodeControl(
      $0.RenameTimecodeControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameTimecodeControl, request, options: options);
  }

  $grpc.ResponseFuture<$0.NoContentResponse> deleteTimecodeControl(
      $0.DeleteTimecodeControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteTimecodeControl, request, options: options);
  }
}

abstract class TimecodeApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.timecode.TimecodeApi';

  TimecodeApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AddTimecodeRequest, $0.NoContentResponse>(
        'AddTimecode',
        addTimecode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddTimecodeRequest.fromBuffer(value),
        ($0.NoContentResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RenameTimecodeRequest, $0.NoContentResponse>(
            'RenameTimecode',
            renameTimecode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RenameTimecodeRequest.fromBuffer(value),
            ($0.NoContentResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DeleteTimecodeRequest, $0.NoContentResponse>(
            'DeleteTimecode',
            deleteTimecode_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DeleteTimecodeRequest.fromBuffer(value),
            ($0.NoContentResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AddTimecodeControlRequest, $0.NoContentResponse>(
            'AddTimecodeControl',
            addTimecodeControl_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddTimecodeControlRequest.fromBuffer(value),
            ($0.NoContentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RenameTimecodeControlRequest,
            $0.NoContentResponse>(
        'RenameTimecodeControl',
        renameTimecodeControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RenameTimecodeControlRequest.fromBuffer(value),
        ($0.NoContentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteTimecodeControlRequest,
            $0.NoContentResponse>(
        'DeleteTimecodeControl',
        deleteTimecodeControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteTimecodeControlRequest.fromBuffer(value),
        ($0.NoContentResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.NoContentResponse> addTimecode_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddTimecodeRequest> request) async {
    return addTimecode(call, await request);
  }

  $async.Future<$0.NoContentResponse> renameTimecode_Pre($grpc.ServiceCall call,
      $async.Future<$0.RenameTimecodeRequest> request) async {
    return renameTimecode(call, await request);
  }

  $async.Future<$0.NoContentResponse> deleteTimecode_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeleteTimecodeRequest> request) async {
    return deleteTimecode(call, await request);
  }

  $async.Future<$0.NoContentResponse> addTimecodeControl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AddTimecodeControlRequest> request) async {
    return addTimecodeControl(call, await request);
  }

  $async.Future<$0.NoContentResponse> renameTimecodeControl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RenameTimecodeControlRequest> request) async {
    return renameTimecodeControl(call, await request);
  }

  $async.Future<$0.NoContentResponse> deleteTimecodeControl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteTimecodeControlRequest> request) async {
    return deleteTimecodeControl(call, await request);
  }

  $async.Future<$0.NoContentResponse> addTimecode(
      $grpc.ServiceCall call, $0.AddTimecodeRequest request);
  $async.Future<$0.NoContentResponse> renameTimecode(
      $grpc.ServiceCall call, $0.RenameTimecodeRequest request);
  $async.Future<$0.NoContentResponse> deleteTimecode(
      $grpc.ServiceCall call, $0.DeleteTimecodeRequest request);
  $async.Future<$0.NoContentResponse> addTimecodeControl(
      $grpc.ServiceCall call, $0.AddTimecodeControlRequest request);
  $async.Future<$0.NoContentResponse> renameTimecodeControl(
      $grpc.ServiceCall call, $0.RenameTimecodeControlRequest request);
  $async.Future<$0.NoContentResponse> deleteTimecodeControl(
      $grpc.ServiceCall call, $0.DeleteTimecodeControlRequest request);
}

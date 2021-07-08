///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'layouts.pb.dart' as $0;
export 'layouts.pb.dart';

class LayoutsApiClient extends $grpc.Client {
  static final _$getLayouts =
      $grpc.ClientMethod<$0.GetLayoutsRequest, $0.Layouts>(
          '/mizer.LayoutsApi/GetLayouts',
          ($0.GetLayoutsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Layouts.fromBuffer(value));
  static final _$addLayout =
      $grpc.ClientMethod<$0.AddLayoutRequest, $0.Layouts>(
          '/mizer.LayoutsApi/AddLayout',
          ($0.AddLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Layouts.fromBuffer(value));
  static final _$removeLayout =
      $grpc.ClientMethod<$0.RemoveLayoutRequest, $0.Layouts>(
          '/mizer.LayoutsApi/RemoveLayout',
          ($0.RemoveLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Layouts.fromBuffer(value));
  static final _$renameLayout =
      $grpc.ClientMethod<$0.RenameLayoutRequest, $0.Layouts>(
          '/mizer.LayoutsApi/RenameLayout',
          ($0.RenameLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Layouts.fromBuffer(value));
  static final _$renameControl =
      $grpc.ClientMethod<$0.RenameControlRequest, $0.LayoutResponse>(
          '/mizer.LayoutsApi/RenameControl',
          ($0.RenameControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.LayoutResponse.fromBuffer(value));
  static final _$moveControl =
      $grpc.ClientMethod<$0.MoveControlRequest, $0.LayoutResponse>(
          '/mizer.LayoutsApi/MoveControl',
          ($0.MoveControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.LayoutResponse.fromBuffer(value));
  static final _$removeControl =
      $grpc.ClientMethod<$0.RemoveControlRequest, $0.LayoutResponse>(
          '/mizer.LayoutsApi/RemoveControl',
          ($0.RemoveControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.LayoutResponse.fromBuffer(value));

  LayoutsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Layouts> getLayouts($0.GetLayoutsRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getLayouts, request, options: options);
  }

  $grpc.ResponseFuture<$0.Layouts> addLayout($0.AddLayoutRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$addLayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.Layouts> removeLayout($0.RemoveLayoutRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeLayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.Layouts> renameLayout($0.RenameLayoutRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$renameLayout, request, options: options);
  }

  $grpc.ResponseFuture<$0.LayoutResponse> renameControl(
      $0.RenameControlRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$renameControl, request, options: options);
  }

  $grpc.ResponseFuture<$0.LayoutResponse> moveControl(
      $0.MoveControlRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$moveControl, request, options: options);
  }

  $grpc.ResponseFuture<$0.LayoutResponse> removeControl(
      $0.RemoveControlRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeControl, request, options: options);
  }
}

abstract class LayoutsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.LayoutsApi';

  LayoutsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetLayoutsRequest, $0.Layouts>(
        'GetLayouts',
        getLayouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLayoutsRequest.fromBuffer(value),
        ($0.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddLayoutRequest, $0.Layouts>(
        'AddLayout',
        addLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddLayoutRequest.fromBuffer(value),
        ($0.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveLayoutRequest, $0.Layouts>(
        'RemoveLayout',
        removeLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveLayoutRequest.fromBuffer(value),
        ($0.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RenameLayoutRequest, $0.Layouts>(
        'RenameLayout',
        renameLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RenameLayoutRequest.fromBuffer(value),
        ($0.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RenameControlRequest, $0.LayoutResponse>(
        'RenameControl',
        renameControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RenameControlRequest.fromBuffer(value),
        ($0.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MoveControlRequest, $0.LayoutResponse>(
        'MoveControl',
        moveControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MoveControlRequest.fromBuffer(value),
        ($0.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveControlRequest, $0.LayoutResponse>(
        'RemoveControl',
        removeControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveControlRequest.fromBuffer(value),
        ($0.LayoutResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Layouts> getLayouts_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetLayoutsRequest> request) async {
    return getLayouts(call, await request);
  }

  $async.Future<$0.Layouts> addLayout_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddLayoutRequest> request) async {
    return addLayout(call, await request);
  }

  $async.Future<$0.Layouts> removeLayout_Pre($grpc.ServiceCall call,
      $async.Future<$0.RemoveLayoutRequest> request) async {
    return removeLayout(call, await request);
  }

  $async.Future<$0.Layouts> renameLayout_Pre($grpc.ServiceCall call,
      $async.Future<$0.RenameLayoutRequest> request) async {
    return renameLayout(call, await request);
  }

  $async.Future<$0.LayoutResponse> renameControl_Pre($grpc.ServiceCall call,
      $async.Future<$0.RenameControlRequest> request) async {
    return renameControl(call, await request);
  }

  $async.Future<$0.LayoutResponse> moveControl_Pre($grpc.ServiceCall call,
      $async.Future<$0.MoveControlRequest> request) async {
    return moveControl(call, await request);
  }

  $async.Future<$0.LayoutResponse> removeControl_Pre($grpc.ServiceCall call,
      $async.Future<$0.RemoveControlRequest> request) async {
    return removeControl(call, await request);
  }

  $async.Future<$0.Layouts> getLayouts(
      $grpc.ServiceCall call, $0.GetLayoutsRequest request);
  $async.Future<$0.Layouts> addLayout(
      $grpc.ServiceCall call, $0.AddLayoutRequest request);
  $async.Future<$0.Layouts> removeLayout(
      $grpc.ServiceCall call, $0.RemoveLayoutRequest request);
  $async.Future<$0.Layouts> renameLayout(
      $grpc.ServiceCall call, $0.RenameLayoutRequest request);
  $async.Future<$0.LayoutResponse> renameControl(
      $grpc.ServiceCall call, $0.RenameControlRequest request);
  $async.Future<$0.LayoutResponse> moveControl(
      $grpc.ServiceCall call, $0.MoveControlRequest request);
  $async.Future<$0.LayoutResponse> removeControl(
      $grpc.ServiceCall call, $0.RemoveControlRequest request);
}

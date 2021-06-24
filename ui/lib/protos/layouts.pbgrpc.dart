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

  $async.Future<$0.Layouts> getLayouts(
      $grpc.ServiceCall call, $0.GetLayoutsRequest request);
  $async.Future<$0.Layouts> addLayout(
      $grpc.ServiceCall call, $0.AddLayoutRequest request);
  $async.Future<$0.Layouts> removeLayout(
      $grpc.ServiceCall call, $0.RemoveLayoutRequest request);
  $async.Future<$0.Layouts> renameLayout(
      $grpc.ServiceCall call, $0.RenameLayoutRequest request);
}

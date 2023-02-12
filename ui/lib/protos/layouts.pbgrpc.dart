///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'layouts.pb.dart' as $1;
export 'layouts.pb.dart';

class LayoutsApiClient extends $grpc.Client {
  static final _$getLayouts =
      $grpc.ClientMethod<$1.GetLayoutsRequest, $1.Layouts>(
          '/mizer.LayoutsApi/GetLayouts',
          ($1.GetLayoutsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Layouts.fromBuffer(value));
  static final _$addLayout =
      $grpc.ClientMethod<$1.AddLayoutRequest, $1.Layouts>(
          '/mizer.LayoutsApi/AddLayout',
          ($1.AddLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Layouts.fromBuffer(value));
  static final _$removeLayout =
      $grpc.ClientMethod<$1.RemoveLayoutRequest, $1.Layouts>(
          '/mizer.LayoutsApi/RemoveLayout',
          ($1.RemoveLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Layouts.fromBuffer(value));
  static final _$renameLayout =
      $grpc.ClientMethod<$1.RenameLayoutRequest, $1.Layouts>(
          '/mizer.LayoutsApi/RenameLayout',
          ($1.RenameLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Layouts.fromBuffer(value));
  static final _$renameControl =
      $grpc.ClientMethod<$1.RenameControlRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/RenameControl',
          ($1.RenameControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$moveControl =
      $grpc.ClientMethod<$1.MoveControlRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/MoveControl',
          ($1.MoveControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$updateControlDecoration =
      $grpc.ClientMethod<$1.UpdateControlDecorationRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/UpdateControlDecoration',
          ($1.UpdateControlDecorationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$updateControlBehavior =
      $grpc.ClientMethod<$1.UpdateControlBehaviorRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/UpdateControlBehavior',
          ($1.UpdateControlBehaviorRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$removeControl =
      $grpc.ClientMethod<$1.RemoveControlRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/RemoveControl',
          ($1.RemoveControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$addControl =
      $grpc.ClientMethod<$1.AddControlRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/AddControl',
          ($1.AddControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$addExistingControl =
      $grpc.ClientMethod<$1.AddExistingControlRequest, $1.LayoutResponse>(
          '/mizer.LayoutsApi/AddExistingControl',
          ($1.AddExistingControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.LayoutResponse.fromBuffer(value));
  static final _$readFaderValue =
      $grpc.ClientMethod<$1.ReadFaderValueRequest, $1.FaderValueResponse>(
          '/mizer.LayoutsApi/ReadFaderValue',
          ($1.ReadFaderValueRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.FaderValueResponse.fromBuffer(value));

  LayoutsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Layouts> getLayouts($1.GetLayoutsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLayouts, request, options: options);
  }

  $grpc.ResponseFuture<$1.Layouts> addLayout($1.AddLayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addLayout, request, options: options);
  }

  $grpc.ResponseFuture<$1.Layouts> removeLayout($1.RemoveLayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeLayout, request, options: options);
  }

  $grpc.ResponseFuture<$1.Layouts> renameLayout($1.RenameLayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameLayout, request, options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> renameControl(
      $1.RenameControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameControl, request, options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> moveControl(
      $1.MoveControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveControl, request, options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> updateControlDecoration(
      $1.UpdateControlDecorationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateControlDecoration, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> updateControlBehavior(
      $1.UpdateControlBehaviorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateControlBehavior, request, options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> removeControl(
      $1.RemoveControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeControl, request, options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> addControl(
      $1.AddControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addControl, request, options: options);
  }

  $grpc.ResponseFuture<$1.LayoutResponse> addExistingControl(
      $1.AddExistingControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addExistingControl, request, options: options);
  }

  $grpc.ResponseFuture<$1.FaderValueResponse> readFaderValue(
      $1.ReadFaderValueRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readFaderValue, request, options: options);
  }
}

abstract class LayoutsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.LayoutsApi';

  LayoutsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetLayoutsRequest, $1.Layouts>(
        'GetLayouts',
        getLayouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetLayoutsRequest.fromBuffer(value),
        ($1.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddLayoutRequest, $1.Layouts>(
        'AddLayout',
        addLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddLayoutRequest.fromBuffer(value),
        ($1.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemoveLayoutRequest, $1.Layouts>(
        'RemoveLayout',
        removeLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RemoveLayoutRequest.fromBuffer(value),
        ($1.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RenameLayoutRequest, $1.Layouts>(
        'RenameLayout',
        renameLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RenameLayoutRequest.fromBuffer(value),
        ($1.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RenameControlRequest, $1.LayoutResponse>(
        'RenameControl',
        renameControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RenameControlRequest.fromBuffer(value),
        ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MoveControlRequest, $1.LayoutResponse>(
        'MoveControl',
        moveControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MoveControlRequest.fromBuffer(value),
        ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateControlDecorationRequest,
            $1.LayoutResponse>(
        'UpdateControlDecoration',
        updateControlDecoration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateControlDecorationRequest.fromBuffer(value),
        ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.UpdateControlBehaviorRequest, $1.LayoutResponse>(
            'UpdateControlBehavior',
            updateControlBehavior_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.UpdateControlBehaviorRequest.fromBuffer(value),
            ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RemoveControlRequest, $1.LayoutResponse>(
        'RemoveControl',
        removeControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RemoveControlRequest.fromBuffer(value),
        ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddControlRequest, $1.LayoutResponse>(
        'AddControl',
        addControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddControlRequest.fromBuffer(value),
        ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.AddExistingControlRequest, $1.LayoutResponse>(
            'AddExistingControl',
            addExistingControl_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.AddExistingControlRequest.fromBuffer(value),
            ($1.LayoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.ReadFaderValueRequest, $1.FaderValueResponse>(
            'ReadFaderValue',
            readFaderValue_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.ReadFaderValueRequest.fromBuffer(value),
            ($1.FaderValueResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.Layouts> getLayouts_Pre($grpc.ServiceCall call,
      $async.Future<$1.GetLayoutsRequest> request) async {
    return getLayouts(call, await request);
  }

  $async.Future<$1.Layouts> addLayout_Pre($grpc.ServiceCall call,
      $async.Future<$1.AddLayoutRequest> request) async {
    return addLayout(call, await request);
  }

  $async.Future<$1.Layouts> removeLayout_Pre($grpc.ServiceCall call,
      $async.Future<$1.RemoveLayoutRequest> request) async {
    return removeLayout(call, await request);
  }

  $async.Future<$1.Layouts> renameLayout_Pre($grpc.ServiceCall call,
      $async.Future<$1.RenameLayoutRequest> request) async {
    return renameLayout(call, await request);
  }

  $async.Future<$1.LayoutResponse> renameControl_Pre($grpc.ServiceCall call,
      $async.Future<$1.RenameControlRequest> request) async {
    return renameControl(call, await request);
  }

  $async.Future<$1.LayoutResponse> moveControl_Pre($grpc.ServiceCall call,
      $async.Future<$1.MoveControlRequest> request) async {
    return moveControl(call, await request);
  }

  $async.Future<$1.LayoutResponse> updateControlDecoration_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateControlDecorationRequest> request) async {
    return updateControlDecoration(call, await request);
  }

  $async.Future<$1.LayoutResponse> updateControlBehavior_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateControlBehaviorRequest> request) async {
    return updateControlBehavior(call, await request);
  }

  $async.Future<$1.LayoutResponse> removeControl_Pre($grpc.ServiceCall call,
      $async.Future<$1.RemoveControlRequest> request) async {
    return removeControl(call, await request);
  }

  $async.Future<$1.LayoutResponse> addControl_Pre($grpc.ServiceCall call,
      $async.Future<$1.AddControlRequest> request) async {
    return addControl(call, await request);
  }

  $async.Future<$1.LayoutResponse> addExistingControl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AddExistingControlRequest> request) async {
    return addExistingControl(call, await request);
  }

  $async.Future<$1.FaderValueResponse> readFaderValue_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ReadFaderValueRequest> request) async {
    return readFaderValue(call, await request);
  }

  $async.Future<$1.Layouts> getLayouts(
      $grpc.ServiceCall call, $1.GetLayoutsRequest request);
  $async.Future<$1.Layouts> addLayout(
      $grpc.ServiceCall call, $1.AddLayoutRequest request);
  $async.Future<$1.Layouts> removeLayout(
      $grpc.ServiceCall call, $1.RemoveLayoutRequest request);
  $async.Future<$1.Layouts> renameLayout(
      $grpc.ServiceCall call, $1.RenameLayoutRequest request);
  $async.Future<$1.LayoutResponse> renameControl(
      $grpc.ServiceCall call, $1.RenameControlRequest request);
  $async.Future<$1.LayoutResponse> moveControl(
      $grpc.ServiceCall call, $1.MoveControlRequest request);
  $async.Future<$1.LayoutResponse> updateControlDecoration(
      $grpc.ServiceCall call, $1.UpdateControlDecorationRequest request);
  $async.Future<$1.LayoutResponse> updateControlBehavior(
      $grpc.ServiceCall call, $1.UpdateControlBehaviorRequest request);
  $async.Future<$1.LayoutResponse> removeControl(
      $grpc.ServiceCall call, $1.RemoveControlRequest request);
  $async.Future<$1.LayoutResponse> addControl(
      $grpc.ServiceCall call, $1.AddControlRequest request);
  $async.Future<$1.LayoutResponse> addExistingControl(
      $grpc.ServiceCall call, $1.AddExistingControlRequest request);
  $async.Future<$1.FaderValueResponse> readFaderValue(
      $grpc.ServiceCall call, $1.ReadFaderValueRequest request);
}

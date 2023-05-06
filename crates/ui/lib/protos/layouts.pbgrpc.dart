///
//  Generated code. Do not modify.
//  source: layouts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'layouts.pb.dart' as $3;
export 'layouts.pb.dart';

class LayoutsApiClient extends $grpc.Client {
  static final _$getLayouts =
      $grpc.ClientMethod<$3.GetLayoutsRequest, $3.Layouts>(
          '/mizer.LayoutsApi/GetLayouts',
          ($3.GetLayoutsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.Layouts.fromBuffer(value));
  static final _$addLayout =
      $grpc.ClientMethod<$3.AddLayoutRequest, $3.Layouts>(
          '/mizer.LayoutsApi/AddLayout',
          ($3.AddLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.Layouts.fromBuffer(value));
  static final _$removeLayout =
      $grpc.ClientMethod<$3.RemoveLayoutRequest, $3.Layouts>(
          '/mizer.LayoutsApi/RemoveLayout',
          ($3.RemoveLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.Layouts.fromBuffer(value));
  static final _$renameLayout =
      $grpc.ClientMethod<$3.RenameLayoutRequest, $3.Layouts>(
          '/mizer.LayoutsApi/RenameLayout',
          ($3.RenameLayoutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.Layouts.fromBuffer(value));
  static final _$renameControl =
      $grpc.ClientMethod<$3.RenameControlRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/RenameControl',
          ($3.RenameControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$moveControl =
      $grpc.ClientMethod<$3.MoveControlRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/MoveControl',
          ($3.MoveControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$resizeControl =
      $grpc.ClientMethod<$3.ResizeControlRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/ResizeControl',
          ($3.ResizeControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$updateControlDecoration =
      $grpc.ClientMethod<$3.UpdateControlDecorationRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/UpdateControlDecoration',
          ($3.UpdateControlDecorationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$updateControlBehavior =
      $grpc.ClientMethod<$3.UpdateControlBehaviorRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/UpdateControlBehavior',
          ($3.UpdateControlBehaviorRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$removeControl =
      $grpc.ClientMethod<$3.RemoveControlRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/RemoveControl',
          ($3.RemoveControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$addControl =
      $grpc.ClientMethod<$3.AddControlRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/AddControl',
          ($3.AddControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$addExistingControl =
      $grpc.ClientMethod<$3.AddExistingControlRequest, $3.LayoutResponse>(
          '/mizer.LayoutsApi/AddExistingControl',
          ($3.AddExistingControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.LayoutResponse.fromBuffer(value));
  static final _$readFaderValue =
      $grpc.ClientMethod<$3.ReadFaderValueRequest, $3.FaderValueResponse>(
          '/mizer.LayoutsApi/ReadFaderValue',
          ($3.ReadFaderValueRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $3.FaderValueResponse.fromBuffer(value));

  LayoutsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$3.Layouts> getLayouts($3.GetLayoutsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLayouts, request, options: options);
  }

  $grpc.ResponseFuture<$3.Layouts> addLayout($3.AddLayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addLayout, request, options: options);
  }

  $grpc.ResponseFuture<$3.Layouts> removeLayout($3.RemoveLayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeLayout, request, options: options);
  }

  $grpc.ResponseFuture<$3.Layouts> renameLayout($3.RenameLayoutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameLayout, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> renameControl(
      $3.RenameControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameControl, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> moveControl(
      $3.MoveControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveControl, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> resizeControl(
      $3.ResizeControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resizeControl, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> updateControlDecoration(
      $3.UpdateControlDecorationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateControlDecoration, request,
        options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> updateControlBehavior(
      $3.UpdateControlBehaviorRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateControlBehavior, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> removeControl(
      $3.RemoveControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeControl, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> addControl(
      $3.AddControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addControl, request, options: options);
  }

  $grpc.ResponseFuture<$3.LayoutResponse> addExistingControl(
      $3.AddExistingControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addExistingControl, request, options: options);
  }

  $grpc.ResponseFuture<$3.FaderValueResponse> readFaderValue(
      $3.ReadFaderValueRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$readFaderValue, request, options: options);
  }
}

abstract class LayoutsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.LayoutsApi';

  LayoutsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.GetLayoutsRequest, $3.Layouts>(
        'GetLayouts',
        getLayouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetLayoutsRequest.fromBuffer(value),
        ($3.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.AddLayoutRequest, $3.Layouts>(
        'AddLayout',
        addLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.AddLayoutRequest.fromBuffer(value),
        ($3.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.RemoveLayoutRequest, $3.Layouts>(
        'RemoveLayout',
        removeLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.RemoveLayoutRequest.fromBuffer(value),
        ($3.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.RenameLayoutRequest, $3.Layouts>(
        'RenameLayout',
        renameLayout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.RenameLayoutRequest.fromBuffer(value),
        ($3.Layouts value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.RenameControlRequest, $3.LayoutResponse>(
        'RenameControl',
        renameControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.RenameControlRequest.fromBuffer(value),
        ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.MoveControlRequest, $3.LayoutResponse>(
        'MoveControl',
        moveControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.MoveControlRequest.fromBuffer(value),
        ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.ResizeControlRequest, $3.LayoutResponse>(
        'ResizeControl',
        resizeControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.ResizeControlRequest.fromBuffer(value),
        ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UpdateControlDecorationRequest,
            $3.LayoutResponse>(
        'UpdateControlDecoration',
        updateControlDecoration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.UpdateControlDecorationRequest.fromBuffer(value),
        ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.UpdateControlBehaviorRequest, $3.LayoutResponse>(
            'UpdateControlBehavior',
            updateControlBehavior_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.UpdateControlBehaviorRequest.fromBuffer(value),
            ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.RemoveControlRequest, $3.LayoutResponse>(
        'RemoveControl',
        removeControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.RemoveControlRequest.fromBuffer(value),
        ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.AddControlRequest, $3.LayoutResponse>(
        'AddControl',
        addControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.AddControlRequest.fromBuffer(value),
        ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.AddExistingControlRequest, $3.LayoutResponse>(
            'AddExistingControl',
            addExistingControl_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.AddExistingControlRequest.fromBuffer(value),
            ($3.LayoutResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$3.ReadFaderValueRequest, $3.FaderValueResponse>(
            'ReadFaderValue',
            readFaderValue_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $3.ReadFaderValueRequest.fromBuffer(value),
            ($3.FaderValueResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.Layouts> getLayouts_Pre($grpc.ServiceCall call,
      $async.Future<$3.GetLayoutsRequest> request) async {
    return getLayouts(call, await request);
  }

  $async.Future<$3.Layouts> addLayout_Pre($grpc.ServiceCall call,
      $async.Future<$3.AddLayoutRequest> request) async {
    return addLayout(call, await request);
  }

  $async.Future<$3.Layouts> removeLayout_Pre($grpc.ServiceCall call,
      $async.Future<$3.RemoveLayoutRequest> request) async {
    return removeLayout(call, await request);
  }

  $async.Future<$3.Layouts> renameLayout_Pre($grpc.ServiceCall call,
      $async.Future<$3.RenameLayoutRequest> request) async {
    return renameLayout(call, await request);
  }

  $async.Future<$3.LayoutResponse> renameControl_Pre($grpc.ServiceCall call,
      $async.Future<$3.RenameControlRequest> request) async {
    return renameControl(call, await request);
  }

  $async.Future<$3.LayoutResponse> moveControl_Pre($grpc.ServiceCall call,
      $async.Future<$3.MoveControlRequest> request) async {
    return moveControl(call, await request);
  }

  $async.Future<$3.LayoutResponse> resizeControl_Pre($grpc.ServiceCall call,
      $async.Future<$3.ResizeControlRequest> request) async {
    return resizeControl(call, await request);
  }

  $async.Future<$3.LayoutResponse> updateControlDecoration_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.UpdateControlDecorationRequest> request) async {
    return updateControlDecoration(call, await request);
  }

  $async.Future<$3.LayoutResponse> updateControlBehavior_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.UpdateControlBehaviorRequest> request) async {
    return updateControlBehavior(call, await request);
  }

  $async.Future<$3.LayoutResponse> removeControl_Pre($grpc.ServiceCall call,
      $async.Future<$3.RemoveControlRequest> request) async {
    return removeControl(call, await request);
  }

  $async.Future<$3.LayoutResponse> addControl_Pre($grpc.ServiceCall call,
      $async.Future<$3.AddControlRequest> request) async {
    return addControl(call, await request);
  }

  $async.Future<$3.LayoutResponse> addExistingControl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.AddExistingControlRequest> request) async {
    return addExistingControl(call, await request);
  }

  $async.Future<$3.FaderValueResponse> readFaderValue_Pre(
      $grpc.ServiceCall call,
      $async.Future<$3.ReadFaderValueRequest> request) async {
    return readFaderValue(call, await request);
  }

  $async.Future<$3.Layouts> getLayouts(
      $grpc.ServiceCall call, $3.GetLayoutsRequest request);
  $async.Future<$3.Layouts> addLayout(
      $grpc.ServiceCall call, $3.AddLayoutRequest request);
  $async.Future<$3.Layouts> removeLayout(
      $grpc.ServiceCall call, $3.RemoveLayoutRequest request);
  $async.Future<$3.Layouts> renameLayout(
      $grpc.ServiceCall call, $3.RenameLayoutRequest request);
  $async.Future<$3.LayoutResponse> renameControl(
      $grpc.ServiceCall call, $3.RenameControlRequest request);
  $async.Future<$3.LayoutResponse> moveControl(
      $grpc.ServiceCall call, $3.MoveControlRequest request);
  $async.Future<$3.LayoutResponse> resizeControl(
      $grpc.ServiceCall call, $3.ResizeControlRequest request);
  $async.Future<$3.LayoutResponse> updateControlDecoration(
      $grpc.ServiceCall call, $3.UpdateControlDecorationRequest request);
  $async.Future<$3.LayoutResponse> updateControlBehavior(
      $grpc.ServiceCall call, $3.UpdateControlBehaviorRequest request);
  $async.Future<$3.LayoutResponse> removeControl(
      $grpc.ServiceCall call, $3.RemoveControlRequest request);
  $async.Future<$3.LayoutResponse> addControl(
      $grpc.ServiceCall call, $3.AddControlRequest request);
  $async.Future<$3.LayoutResponse> addExistingControl(
      $grpc.ServiceCall call, $3.AddExistingControlRequest request);
  $async.Future<$3.FaderValueResponse> readFaderValue(
      $grpc.ServiceCall call, $3.ReadFaderValueRequest request);
}

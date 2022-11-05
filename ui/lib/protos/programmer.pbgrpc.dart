///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'programmer.pb.dart' as $1;
export 'programmer.pb.dart';

class ProgrammerApiClient extends $grpc.Client {
  static final _$subscribeToProgrammer =
      $grpc.ClientMethod<$1.SubscribeProgrammerRequest, $1.ProgrammerState>(
          '/mizer.programmer.ProgrammerApi/SubscribeToProgrammer',
          ($1.SubscribeProgrammerRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ProgrammerState.fromBuffer(value));
  static final _$writeControl =
      $grpc.ClientMethod<$1.WriteControlRequest, $1.WriteControlResponse>(
          '/mizer.programmer.ProgrammerApi/WriteControl',
          ($1.WriteControlRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.WriteControlResponse.fromBuffer(value));
  static final _$selectFixtures =
      $grpc.ClientMethod<$1.SelectFixturesRequest, $1.SelectFixturesResponse>(
          '/mizer.programmer.ProgrammerApi/SelectFixtures',
          ($1.SelectFixturesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SelectFixturesResponse.fromBuffer(value));
  static final _$unselectFixtures = $grpc.ClientMethod<
          $1.UnselectFixturesRequest, $1.UnselectFixturesResponse>(
      '/mizer.programmer.ProgrammerApi/UnselectFixtures',
      ($1.UnselectFixturesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UnselectFixturesResponse.fromBuffer(value));
  static final _$clear = $grpc.ClientMethod<$1.ClearRequest, $1.ClearResponse>(
      '/mizer.programmer.ProgrammerApi/Clear',
      ($1.ClearRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ClearResponse.fromBuffer(value));
  static final _$highlight =
      $grpc.ClientMethod<$1.HighlightRequest, $1.HighlightResponse>(
          '/mizer.programmer.ProgrammerApi/Highlight',
          ($1.HighlightRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.HighlightResponse.fromBuffer(value));
  static final _$store = $grpc.ClientMethod<$1.StoreRequest, $1.StoreResponse>(
      '/mizer.programmer.ProgrammerApi/Store',
      ($1.StoreRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StoreResponse.fromBuffer(value));
  static final _$getPresets = $grpc.ClientMethod<$1.PresetsRequest, $1.Presets>(
      '/mizer.programmer.ProgrammerApi/GetPresets',
      ($1.PresetsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Presets.fromBuffer(value));
  static final _$callPreset =
      $grpc.ClientMethod<$1.PresetId, $1.CallPresetResponse>(
          '/mizer.programmer.ProgrammerApi/CallPreset',
          ($1.PresetId value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.CallPresetResponse.fromBuffer(value));
  static final _$getGroups = $grpc.ClientMethod<$1.GroupsRequest, $1.Groups>(
      '/mizer.programmer.ProgrammerApi/GetGroups',
      ($1.GroupsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Groups.fromBuffer(value));
  static final _$selectGroup =
      $grpc.ClientMethod<$1.SelectGroupRequest, $1.SelectGroupResponse>(
          '/mizer.programmer.ProgrammerApi/SelectGroup',
          ($1.SelectGroupRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SelectGroupResponse.fromBuffer(value));
  static final _$addGroup = $grpc.ClientMethod<$1.AddGroupRequest, $1.Group>(
      '/mizer.programmer.ProgrammerApi/AddGroup',
      ($1.AddGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Group.fromBuffer(value));
  static final _$assignFixturesToGroup = $grpc.ClientMethod<
          $1.AssignFixturesToGroupRequest, $1.AssignFixturesToGroupResponse>(
      '/mizer.programmer.ProgrammerApi/AssignFixturesToGroup',
      ($1.AssignFixturesToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AssignFixturesToGroupResponse.fromBuffer(value));
  static final _$assignFixtureSelectionToGroup = $grpc.ClientMethod<
          $1.AssignFixtureSelectionToGroupRequest,
          $1.AssignFixturesToGroupResponse>(
      '/mizer.programmer.ProgrammerApi/AssignFixtureSelectionToGroup',
      ($1.AssignFixtureSelectionToGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AssignFixturesToGroupResponse.fromBuffer(value));

  ProgrammerApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$1.ProgrammerState> subscribeToProgrammer(
      $1.SubscribeProgrammerRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribeToProgrammer, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$1.WriteControlResponse> writeControl(
      $1.WriteControlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$writeControl, request, options: options);
  }

  $grpc.ResponseFuture<$1.SelectFixturesResponse> selectFixtures(
      $1.SelectFixturesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$selectFixtures, request, options: options);
  }

  $grpc.ResponseFuture<$1.UnselectFixturesResponse> unselectFixtures(
      $1.UnselectFixturesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unselectFixtures, request, options: options);
  }

  $grpc.ResponseFuture<$1.ClearResponse> clear($1.ClearRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$clear, request, options: options);
  }

  $grpc.ResponseFuture<$1.HighlightResponse> highlight(
      $1.HighlightRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$highlight, request, options: options);
  }

  $grpc.ResponseFuture<$1.StoreResponse> store($1.StoreRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$store, request, options: options);
  }

  $grpc.ResponseFuture<$1.Presets> getPresets($1.PresetsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPresets, request, options: options);
  }

  $grpc.ResponseFuture<$1.CallPresetResponse> callPreset($1.PresetId request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$callPreset, request, options: options);
  }

  $grpc.ResponseFuture<$1.Groups> getGroups($1.GroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGroups, request, options: options);
  }

  $grpc.ResponseFuture<$1.SelectGroupResponse> selectGroup(
      $1.SelectGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$selectGroup, request, options: options);
  }

  $grpc.ResponseFuture<$1.Group> addGroup($1.AddGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addGroup, request, options: options);
  }

  $grpc.ResponseFuture<$1.AssignFixturesToGroupResponse> assignFixturesToGroup(
      $1.AssignFixturesToGroupRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$assignFixturesToGroup, request, options: options);
  }

  $grpc.ResponseFuture<$1.AssignFixturesToGroupResponse>
      assignFixtureSelectionToGroup(
          $1.AssignFixtureSelectionToGroupRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$assignFixtureSelectionToGroup, request,
        options: options);
  }
}

abstract class ProgrammerApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.programmer.ProgrammerApi';

  ProgrammerApiServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$1.SubscribeProgrammerRequest, $1.ProgrammerState>(
            'SubscribeToProgrammer',
            subscribeToProgrammer_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $1.SubscribeProgrammerRequest.fromBuffer(value),
            ($1.ProgrammerState value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.WriteControlRequest, $1.WriteControlResponse>(
            'WriteControl',
            writeControl_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.WriteControlRequest.fromBuffer(value),
            ($1.WriteControlResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SelectFixturesRequest,
            $1.SelectFixturesResponse>(
        'SelectFixtures',
        selectFixtures_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SelectFixturesRequest.fromBuffer(value),
        ($1.SelectFixturesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UnselectFixturesRequest,
            $1.UnselectFixturesResponse>(
        'UnselectFixtures',
        unselectFixtures_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UnselectFixturesRequest.fromBuffer(value),
        ($1.UnselectFixturesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ClearRequest, $1.ClearResponse>(
        'Clear',
        clear_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ClearRequest.fromBuffer(value),
        ($1.ClearResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.HighlightRequest, $1.HighlightResponse>(
        'Highlight',
        highlight_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.HighlightRequest.fromBuffer(value),
        ($1.HighlightResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.StoreRequest, $1.StoreResponse>(
        'Store',
        store_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.StoreRequest.fromBuffer(value),
        ($1.StoreResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PresetsRequest, $1.Presets>(
        'GetPresets',
        getPresets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PresetsRequest.fromBuffer(value),
        ($1.Presets value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PresetId, $1.CallPresetResponse>(
        'CallPreset',
        callPreset_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PresetId.fromBuffer(value),
        ($1.CallPresetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GroupsRequest, $1.Groups>(
        'GetGroups',
        getGroups_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GroupsRequest.fromBuffer(value),
        ($1.Groups value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.SelectGroupRequest, $1.SelectGroupResponse>(
            'SelectGroup',
            selectGroup_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.SelectGroupRequest.fromBuffer(value),
            ($1.SelectGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddGroupRequest, $1.Group>(
        'AddGroup',
        addGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddGroupRequest.fromBuffer(value),
        ($1.Group value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AssignFixturesToGroupRequest,
            $1.AssignFixturesToGroupResponse>(
        'AssignFixturesToGroup',
        assignFixturesToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AssignFixturesToGroupRequest.fromBuffer(value),
        ($1.AssignFixturesToGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AssignFixtureSelectionToGroupRequest,
            $1.AssignFixturesToGroupResponse>(
        'AssignFixtureSelectionToGroup',
        assignFixtureSelectionToGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AssignFixtureSelectionToGroupRequest.fromBuffer(value),
        ($1.AssignFixturesToGroupResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$1.ProgrammerState> subscribeToProgrammer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SubscribeProgrammerRequest> request) async* {
    yield* subscribeToProgrammer(call, await request);
  }

  $async.Future<$1.WriteControlResponse> writeControl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.WriteControlRequest> request) async {
    return writeControl(call, await request);
  }

  $async.Future<$1.SelectFixturesResponse> selectFixtures_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SelectFixturesRequest> request) async {
    return selectFixtures(call, await request);
  }

  $async.Future<$1.UnselectFixturesResponse> unselectFixtures_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UnselectFixturesRequest> request) async {
    return unselectFixtures(call, await request);
  }

  $async.Future<$1.ClearResponse> clear_Pre(
      $grpc.ServiceCall call, $async.Future<$1.ClearRequest> request) async {
    return clear(call, await request);
  }

  $async.Future<$1.HighlightResponse> highlight_Pre($grpc.ServiceCall call,
      $async.Future<$1.HighlightRequest> request) async {
    return highlight(call, await request);
  }

  $async.Future<$1.StoreResponse> store_Pre(
      $grpc.ServiceCall call, $async.Future<$1.StoreRequest> request) async {
    return store(call, await request);
  }

  $async.Future<$1.Presets> getPresets_Pre(
      $grpc.ServiceCall call, $async.Future<$1.PresetsRequest> request) async {
    return getPresets(call, await request);
  }

  $async.Future<$1.CallPresetResponse> callPreset_Pre(
      $grpc.ServiceCall call, $async.Future<$1.PresetId> request) async {
    return callPreset(call, await request);
  }

  $async.Future<$1.Groups> getGroups_Pre(
      $grpc.ServiceCall call, $async.Future<$1.GroupsRequest> request) async {
    return getGroups(call, await request);
  }

  $async.Future<$1.SelectGroupResponse> selectGroup_Pre($grpc.ServiceCall call,
      $async.Future<$1.SelectGroupRequest> request) async {
    return selectGroup(call, await request);
  }

  $async.Future<$1.Group> addGroup_Pre(
      $grpc.ServiceCall call, $async.Future<$1.AddGroupRequest> request) async {
    return addGroup(call, await request);
  }

  $async.Future<$1.AssignFixturesToGroupResponse> assignFixturesToGroup_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AssignFixturesToGroupRequest> request) async {
    return assignFixturesToGroup(call, await request);
  }

  $async.Future<$1.AssignFixturesToGroupResponse>
      assignFixtureSelectionToGroup_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.AssignFixtureSelectionToGroupRequest>
              request) async {
    return assignFixtureSelectionToGroup(call, await request);
  }

  $async.Stream<$1.ProgrammerState> subscribeToProgrammer(
      $grpc.ServiceCall call, $1.SubscribeProgrammerRequest request);
  $async.Future<$1.WriteControlResponse> writeControl(
      $grpc.ServiceCall call, $1.WriteControlRequest request);
  $async.Future<$1.SelectFixturesResponse> selectFixtures(
      $grpc.ServiceCall call, $1.SelectFixturesRequest request);
  $async.Future<$1.UnselectFixturesResponse> unselectFixtures(
      $grpc.ServiceCall call, $1.UnselectFixturesRequest request);
  $async.Future<$1.ClearResponse> clear(
      $grpc.ServiceCall call, $1.ClearRequest request);
  $async.Future<$1.HighlightResponse> highlight(
      $grpc.ServiceCall call, $1.HighlightRequest request);
  $async.Future<$1.StoreResponse> store(
      $grpc.ServiceCall call, $1.StoreRequest request);
  $async.Future<$1.Presets> getPresets(
      $grpc.ServiceCall call, $1.PresetsRequest request);
  $async.Future<$1.CallPresetResponse> callPreset(
      $grpc.ServiceCall call, $1.PresetId request);
  $async.Future<$1.Groups> getGroups(
      $grpc.ServiceCall call, $1.GroupsRequest request);
  $async.Future<$1.SelectGroupResponse> selectGroup(
      $grpc.ServiceCall call, $1.SelectGroupRequest request);
  $async.Future<$1.Group> addGroup(
      $grpc.ServiceCall call, $1.AddGroupRequest request);
  $async.Future<$1.AssignFixturesToGroupResponse> assignFixturesToGroup(
      $grpc.ServiceCall call, $1.AssignFixturesToGroupRequest request);
  $async.Future<$1.AssignFixturesToGroupResponse> assignFixtureSelectionToGroup(
      $grpc.ServiceCall call, $1.AssignFixtureSelectionToGroupRequest request);
}

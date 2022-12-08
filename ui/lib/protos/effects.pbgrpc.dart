///
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'effects.pb.dart' as $2;
export 'effects.pb.dart';

class EffectsApiClient extends $grpc.Client {
  static final _$getEffects =
      $grpc.ClientMethod<$2.GetEffectsRequest, $2.Effects>(
          '/mizer.effects.EffectsApi/GetEffects',
          ($2.GetEffectsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Effects.fromBuffer(value));
  static final _$addEffect = $grpc.ClientMethod<$2.AddEffectRequest, $2.Effect>(
      '/mizer.effects.EffectsApi/AddEffect',
      ($2.AddEffectRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Effect.fromBuffer(value));
  static final _$addEffectChannel =
      $grpc.ClientMethod<$2.AddEffectChannelRequest, $2.Effect>(
          '/mizer.effects.EffectsApi/AddEffectChannel',
          ($2.AddEffectChannelRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Effect.fromBuffer(value));
  static final _$deleteEffectChannel =
      $grpc.ClientMethod<$2.DeleteEffectChannelRequest, $2.Effect>(
          '/mizer.effects.EffectsApi/DeleteEffectChannel',
          ($2.DeleteEffectChannelRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Effect.fromBuffer(value));
  static final _$updateEffectStep =
      $grpc.ClientMethod<$2.UpdateEffectStepRequest, $2.Effect>(
          '/mizer.effects.EffectsApi/UpdateEffectStep',
          ($2.UpdateEffectStepRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Effect.fromBuffer(value));
  static final _$addEffectStep =
      $grpc.ClientMethod<$2.AddEffectStepRequest, $2.Effect>(
          '/mizer.effects.EffectsApi/AddEffectStep',
          ($2.AddEffectStepRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Effect.fromBuffer(value));
  static final _$deleteEffectStep =
      $grpc.ClientMethod<$2.DeleteEffectStepRequest, $2.Effect>(
          '/mizer.effects.EffectsApi/DeleteEffectStep',
          ($2.DeleteEffectStepRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Effect.fromBuffer(value));

  EffectsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.Effects> getEffects($2.GetEffectsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEffects, request, options: options);
  }

  $grpc.ResponseFuture<$2.Effect> addEffect($2.AddEffectRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addEffect, request, options: options);
  }

  $grpc.ResponseFuture<$2.Effect> addEffectChannel(
      $2.AddEffectChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addEffectChannel, request, options: options);
  }

  $grpc.ResponseFuture<$2.Effect> deleteEffectChannel(
      $2.DeleteEffectChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEffectChannel, request, options: options);
  }

  $grpc.ResponseFuture<$2.Effect> updateEffectStep(
      $2.UpdateEffectStepRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEffectStep, request, options: options);
  }

  $grpc.ResponseFuture<$2.Effect> addEffectStep($2.AddEffectStepRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addEffectStep, request, options: options);
  }

  $grpc.ResponseFuture<$2.Effect> deleteEffectStep(
      $2.DeleteEffectStepRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEffectStep, request, options: options);
  }
}

abstract class EffectsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.effects.EffectsApi';

  EffectsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetEffectsRequest, $2.Effects>(
        'GetEffects',
        getEffects_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetEffectsRequest.fromBuffer(value),
        ($2.Effects value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddEffectRequest, $2.Effect>(
        'AddEffect',
        addEffect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddEffectRequest.fromBuffer(value),
        ($2.Effect value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddEffectChannelRequest, $2.Effect>(
        'AddEffectChannel',
        addEffectChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.AddEffectChannelRequest.fromBuffer(value),
        ($2.Effect value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteEffectChannelRequest, $2.Effect>(
        'DeleteEffectChannel',
        deleteEffectChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteEffectChannelRequest.fromBuffer(value),
        ($2.Effect value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateEffectStepRequest, $2.Effect>(
        'UpdateEffectStep',
        updateEffectStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateEffectStepRequest.fromBuffer(value),
        ($2.Effect value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddEffectStepRequest, $2.Effect>(
        'AddEffectStep',
        addEffectStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.AddEffectStepRequest.fromBuffer(value),
        ($2.Effect value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteEffectStepRequest, $2.Effect>(
        'DeleteEffectStep',
        deleteEffectStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DeleteEffectStepRequest.fromBuffer(value),
        ($2.Effect value) => value.writeToBuffer()));
  }

  $async.Future<$2.Effects> getEffects_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetEffectsRequest> request) async {
    return getEffects(call, await request);
  }

  $async.Future<$2.Effect> addEffect_Pre($grpc.ServiceCall call,
      $async.Future<$2.AddEffectRequest> request) async {
    return addEffect(call, await request);
  }

  $async.Future<$2.Effect> addEffectChannel_Pre($grpc.ServiceCall call,
      $async.Future<$2.AddEffectChannelRequest> request) async {
    return addEffectChannel(call, await request);
  }

  $async.Future<$2.Effect> deleteEffectChannel_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteEffectChannelRequest> request) async {
    return deleteEffectChannel(call, await request);
  }

  $async.Future<$2.Effect> updateEffectStep_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateEffectStepRequest> request) async {
    return updateEffectStep(call, await request);
  }

  $async.Future<$2.Effect> addEffectStep_Pre($grpc.ServiceCall call,
      $async.Future<$2.AddEffectStepRequest> request) async {
    return addEffectStep(call, await request);
  }

  $async.Future<$2.Effect> deleteEffectStep_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteEffectStepRequest> request) async {
    return deleteEffectStep(call, await request);
  }

  $async.Future<$2.Effects> getEffects(
      $grpc.ServiceCall call, $2.GetEffectsRequest request);
  $async.Future<$2.Effect> addEffect(
      $grpc.ServiceCall call, $2.AddEffectRequest request);
  $async.Future<$2.Effect> addEffectChannel(
      $grpc.ServiceCall call, $2.AddEffectChannelRequest request);
  $async.Future<$2.Effect> deleteEffectChannel(
      $grpc.ServiceCall call, $2.DeleteEffectChannelRequest request);
  $async.Future<$2.Effect> updateEffectStep(
      $grpc.ServiceCall call, $2.UpdateEffectStepRequest request);
  $async.Future<$2.Effect> addEffectStep(
      $grpc.ServiceCall call, $2.AddEffectStepRequest request);
  $async.Future<$2.Effect> deleteEffectStep(
      $grpc.ServiceCall call, $2.DeleteEffectStepRequest request);
}

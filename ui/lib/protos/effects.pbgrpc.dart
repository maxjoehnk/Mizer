///
//  Generated code. Do not modify.
//  source: effects.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

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
  static final _$updateEffectStep =
      $grpc.ClientMethod<$2.UpdateEffectStepRequest, $2.Effect>(
          '/mizer.effects.EffectsApi/UpdateEffectStep',
          ($2.UpdateEffectStepRequest value) => value.writeToBuffer(),
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

  $grpc.ResponseFuture<$2.Effect> updateEffectStep(
      $2.UpdateEffectStepRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEffectStep, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$2.UpdateEffectStepRequest, $2.Effect>(
        'UpdateEffectStep',
        updateEffectStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateEffectStepRequest.fromBuffer(value),
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

  $async.Future<$2.Effect> updateEffectStep_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateEffectStepRequest> request) async {
    return updateEffectStep(call, await request);
  }

  $async.Future<$2.Effects> getEffects(
      $grpc.ServiceCall call, $2.GetEffectsRequest request);
  $async.Future<$2.Effect> addEffect(
      $grpc.ServiceCall call, $2.AddEffectRequest request);
  $async.Future<$2.Effect> updateEffectStep(
      $grpc.ServiceCall call, $2.UpdateEffectStepRequest request);
}

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

  EffectsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.Effects> getEffects($2.GetEffectsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEffects, request, options: options);
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
  }

  $async.Future<$2.Effects> getEffects_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetEffectsRequest> request) async {
    return getEffects(call, await request);
  }

  $async.Future<$2.Effects> getEffects(
      $grpc.ServiceCall call, $2.GetEffectsRequest request);
}

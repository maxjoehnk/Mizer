///
//  Generated code. Do not modify.
//  source: programmer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

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
  static final _$selectFixtures =
      $grpc.ClientMethod<$1.SelectFixturesRequest, $1.SelectFixturesResponse>(
          '/mizer.programmer.ProgrammerApi/SelectFixtures',
          ($1.SelectFixturesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.SelectFixturesResponse.fromBuffer(value));
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

  $grpc.ResponseFuture<$1.SelectFixturesResponse> selectFixtures(
      $1.SelectFixturesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$selectFixtures, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$1.SelectFixturesRequest,
            $1.SelectFixturesResponse>(
        'SelectFixtures',
        selectFixtures_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SelectFixturesRequest.fromBuffer(value),
        ($1.SelectFixturesResponse value) => value.writeToBuffer()));
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
  }

  $async.Stream<$1.ProgrammerState> subscribeToProgrammer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SubscribeProgrammerRequest> request) async* {
    yield* subscribeToProgrammer(call, await request);
  }

  $async.Future<$1.SelectFixturesResponse> selectFixtures_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SelectFixturesRequest> request) async {
    return selectFixtures(call, await request);
  }

  $async.Future<$1.ClearResponse> clear_Pre(
      $grpc.ServiceCall call, $async.Future<$1.ClearRequest> request) async {
    return clear(call, await request);
  }

  $async.Future<$1.HighlightResponse> highlight_Pre($grpc.ServiceCall call,
      $async.Future<$1.HighlightRequest> request) async {
    return highlight(call, await request);
  }

  $async.Stream<$1.ProgrammerState> subscribeToProgrammer(
      $grpc.ServiceCall call, $1.SubscribeProgrammerRequest request);
  $async.Future<$1.SelectFixturesResponse> selectFixtures(
      $grpc.ServiceCall call, $1.SelectFixturesRequest request);
  $async.Future<$1.ClearResponse> clear(
      $grpc.ServiceCall call, $1.ClearRequest request);
  $async.Future<$1.HighlightResponse> highlight(
      $grpc.ServiceCall call, $1.HighlightRequest request);
}

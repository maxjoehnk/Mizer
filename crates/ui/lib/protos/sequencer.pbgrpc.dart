///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'sequencer.pb.dart' as $1;
export 'sequencer.pb.dart';

class SequencerRemoteApiClient extends $grpc.Client {
  static final _$subscribeToSequences =
      $grpc.ClientMethod<$1.GetSequencesRequest, $1.SequencerState>(
          '/mizer.sequencer.SequencerRemoteApi/SubscribeToSequences',
          ($1.GetSequencesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.SequencerState.fromBuffer(value));
  static final _$goSequence =
      $grpc.ClientMethod<$1.SequenceGoRequest, $1.Empty>(
          '/mizer.sequencer.SequencerRemoteApi/GoSequence',
          ($1.SequenceGoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$stopSequence =
      $grpc.ClientMethod<$1.SequenceStopRequest, $1.Empty>(
          '/mizer.sequencer.SequencerRemoteApi/StopSequence',
          ($1.SequenceStopRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  SequencerRemoteApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$1.SequencerState> subscribeToSequences(
      $1.GetSequencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribeToSequences, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> goSequence($1.SequenceGoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$goSequence, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> stopSequence($1.SequenceStopRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopSequence, request, options: options);
  }
}

abstract class SequencerRemoteApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.sequencer.SequencerRemoteApi';

  SequencerRemoteApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetSequencesRequest, $1.SequencerState>(
        'SubscribeToSequences',
        subscribeToSequences_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $1.GetSequencesRequest.fromBuffer(value),
        ($1.SequencerState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SequenceGoRequest, $1.Empty>(
        'GoSequence',
        goSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SequenceGoRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SequenceStopRequest, $1.Empty>(
        'StopSequence',
        stopSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SequenceStopRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Stream<$1.SequencerState> subscribeToSequences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetSequencesRequest> request) async* {
    yield* subscribeToSequences(call, await request);
  }

  $async.Future<$1.Empty> goSequence_Pre($grpc.ServiceCall call,
      $async.Future<$1.SequenceGoRequest> request) async {
    return goSequence(call, await request);
  }

  $async.Future<$1.Empty> stopSequence_Pre($grpc.ServiceCall call,
      $async.Future<$1.SequenceStopRequest> request) async {
    return stopSequence(call, await request);
  }

  $async.Stream<$1.SequencerState> subscribeToSequences(
      $grpc.ServiceCall call, $1.GetSequencesRequest request);
  $async.Future<$1.Empty> goSequence(
      $grpc.ServiceCall call, $1.SequenceGoRequest request);
  $async.Future<$1.Empty> stopSequence(
      $grpc.ServiceCall call, $1.SequenceStopRequest request);
}

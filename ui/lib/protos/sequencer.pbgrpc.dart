///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'sequencer.pb.dart' as $1;
export 'sequencer.pb.dart';

class SequencerApiClient extends $grpc.Client {
  static final _$getSequences =
      $grpc.ClientMethod<$1.GetSequencesRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/GetSequences',
          ($1.GetSequencesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$addSequence =
      $grpc.ClientMethod<$1.AddSequenceRequest, $1.Sequence>(
          '/mizer.sequencer.SequencerApi/AddSequence',
          ($1.AddSequenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequence.fromBuffer(value));
  static final _$sequenceGo =
      $grpc.ClientMethod<$1.SequenceGoRequest, $1.EmptyResponse>(
          '/mizer.sequencer.SequencerApi/SequenceGo',
          ($1.SequenceGoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.EmptyResponse.fromBuffer(value));

  SequencerApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Sequences> getSequences(
      $1.GetSequencesRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getSequences, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequence> addSequence($1.AddSequenceRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$addSequence, request, options: options);
  }

  $grpc.ResponseFuture<$1.EmptyResponse> sequenceGo(
      $1.SequenceGoRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sequenceGo, request, options: options);
  }
}

abstract class SequencerApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.sequencer.SequencerApi';

  SequencerApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.GetSequencesRequest, $1.Sequences>(
        'GetSequences',
        getSequences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetSequencesRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddSequenceRequest, $1.Sequence>(
        'AddSequence',
        addSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AddSequenceRequest.fromBuffer(value),
        ($1.Sequence value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SequenceGoRequest, $1.EmptyResponse>(
        'SequenceGo',
        sequenceGo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SequenceGoRequest.fromBuffer(value),
        ($1.EmptyResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.Sequences> getSequences_Pre($grpc.ServiceCall call,
      $async.Future<$1.GetSequencesRequest> request) async {
    return getSequences(call, await request);
  }

  $async.Future<$1.Sequence> addSequence_Pre($grpc.ServiceCall call,
      $async.Future<$1.AddSequenceRequest> request) async {
    return addSequence(call, await request);
  }

  $async.Future<$1.EmptyResponse> sequenceGo_Pre($grpc.ServiceCall call,
      $async.Future<$1.SequenceGoRequest> request) async {
    return sequenceGo(call, await request);
  }

  $async.Future<$1.Sequences> getSequences(
      $grpc.ServiceCall call, $1.GetSequencesRequest request);
  $async.Future<$1.Sequence> addSequence(
      $grpc.ServiceCall call, $1.AddSequenceRequest request);
  $async.Future<$1.EmptyResponse> sequenceGo(
      $grpc.ServiceCall call, $1.SequenceGoRequest request);
}

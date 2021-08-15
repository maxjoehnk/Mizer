///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'sequencer.pb.dart' as $0;
export 'sequencer.pb.dart';

class SequencerApiClient extends $grpc.Client {
  static final _$getSequences =
      $grpc.ClientMethod<$0.GetSequencesRequest, $0.Sequences>(
          '/mizer.SequencerApi/GetSequences',
          ($0.GetSequencesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Sequences.fromBuffer(value));
  static final _$addSequence =
      $grpc.ClientMethod<$0.AddSequenceRequest, $0.Sequence>(
          '/mizer.SequencerApi/AddSequence',
          ($0.AddSequenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Sequence.fromBuffer(value));
  static final _$sequenceGo =
      $grpc.ClientMethod<$0.SequenceGoRequest, $0.EmptyResponse>(
          '/mizer.SequencerApi/SequenceGo',
          ($0.SequenceGoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.EmptyResponse.fromBuffer(value));

  SequencerApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Sequences> getSequences(
      $0.GetSequencesRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getSequences, request, options: options);
  }

  $grpc.ResponseFuture<$0.Sequence> addSequence($0.AddSequenceRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$addSequence, request, options: options);
  }

  $grpc.ResponseFuture<$0.EmptyResponse> sequenceGo(
      $0.SequenceGoRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$sequenceGo, request, options: options);
  }
}

abstract class SequencerApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.SequencerApi';

  SequencerApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetSequencesRequest, $0.Sequences>(
        'GetSequences',
        getSequences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSequencesRequest.fromBuffer(value),
        ($0.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddSequenceRequest, $0.Sequence>(
        'AddSequence',
        addSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AddSequenceRequest.fromBuffer(value),
        ($0.Sequence value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SequenceGoRequest, $0.EmptyResponse>(
        'SequenceGo',
        sequenceGo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SequenceGoRequest.fromBuffer(value),
        ($0.EmptyResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Sequences> getSequences_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetSequencesRequest> request) async {
    return getSequences(call, await request);
  }

  $async.Future<$0.Sequence> addSequence_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddSequenceRequest> request) async {
    return addSequence(call, await request);
  }

  $async.Future<$0.EmptyResponse> sequenceGo_Pre($grpc.ServiceCall call,
      $async.Future<$0.SequenceGoRequest> request) async {
    return sequenceGo(call, await request);
  }

  $async.Future<$0.Sequences> getSequences(
      $grpc.ServiceCall call, $0.GetSequencesRequest request);
  $async.Future<$0.Sequence> addSequence(
      $grpc.ServiceCall call, $0.AddSequenceRequest request);
  $async.Future<$0.EmptyResponse> sequenceGo(
      $grpc.ServiceCall call, $0.SequenceGoRequest request);
}

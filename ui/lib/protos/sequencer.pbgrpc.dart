///
//  Generated code. Do not modify.
//  source: sequencer.proto
//
// @dart = 2.12
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
  static final _$getSequence =
      $grpc.ClientMethod<$1.GetSequenceRequest, $1.Sequence>(
          '/mizer.sequencer.SequencerApi/GetSequence',
          ($1.GetSequenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequence.fromBuffer(value));
  static final _$addSequence =
      $grpc.ClientMethod<$1.AddSequenceRequest, $1.Sequence>(
          '/mizer.sequencer.SequencerApi/AddSequence',
          ($1.AddSequenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequence.fromBuffer(value));
  static final _$deleteSequence =
      $grpc.ClientMethod<$1.DeleteSequenceRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/DeleteSequence',
          ($1.DeleteSequenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$sequenceGo =
      $grpc.ClientMethod<$1.SequenceGoRequest, $1.EmptyResponse>(
          '/mizer.sequencer.SequencerApi/SequenceGo',
          ($1.SequenceGoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.EmptyResponse.fromBuffer(value));
  static final _$sequenceStop =
      $grpc.ClientMethod<$1.SequenceStopRequest, $1.EmptyResponse>(
          '/mizer.sequencer.SequencerApi/SequenceStop',
          ($1.SequenceStopRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.EmptyResponse.fromBuffer(value));
  static final _$updateCueTrigger =
      $grpc.ClientMethod<$1.CueTriggerRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateCueTrigger',
          ($1.CueTriggerRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateCueTriggerTime =
      $grpc.ClientMethod<$1.CueTriggerTimeRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateCueTriggerTime',
          ($1.CueTriggerTimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateCueName =
      $grpc.ClientMethod<$1.CueNameRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateCueName',
          ($1.CueNameRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateCueValue =
      $grpc.ClientMethod<$1.CueValueRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateCueValue',
          ($1.CueValueRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateCueFadeTime =
      $grpc.ClientMethod<$1.CueTimingRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateCueFadeTime',
          ($1.CueTimingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateCueDelayTime =
      $grpc.ClientMethod<$1.CueTimingRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateCueDelayTime',
          ($1.CueTimingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateSequenceWrapAround =
      $grpc.ClientMethod<$1.SequenceWrapAroundRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateSequenceWrapAround',
          ($1.SequenceWrapAroundRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));
  static final _$updateSequenceName =
      $grpc.ClientMethod<$1.CueNameRequest, $1.Sequences>(
          '/mizer.sequencer.SequencerApi/UpdateSequenceName',
          ($1.CueNameRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Sequences.fromBuffer(value));

  SequencerApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Sequences> getSequences(
      $1.GetSequencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSequences, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequence> getSequence($1.GetSequenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSequence, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequence> addSequence($1.AddSequenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addSequence, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> deleteSequence(
      $1.DeleteSequenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteSequence, request, options: options);
  }

  $grpc.ResponseFuture<$1.EmptyResponse> sequenceGo(
      $1.SequenceGoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sequenceGo, request, options: options);
  }

  $grpc.ResponseFuture<$1.EmptyResponse> sequenceStop(
      $1.SequenceStopRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sequenceStop, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateCueTrigger(
      $1.CueTriggerRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCueTrigger, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateCueTriggerTime(
      $1.CueTriggerTimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCueTriggerTime, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateCueName($1.CueNameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCueName, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateCueValue($1.CueValueRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCueValue, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateCueFadeTime(
      $1.CueTimingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCueFadeTime, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateCueDelayTime(
      $1.CueTimingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCueDelayTime, request, options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateSequenceWrapAround(
      $1.SequenceWrapAroundRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSequenceWrapAround, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Sequences> updateSequenceName(
      $1.CueNameRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSequenceName, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$1.GetSequenceRequest, $1.Sequence>(
        'GetSequence',
        getSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetSequenceRequest.fromBuffer(value),
        ($1.Sequence value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddSequenceRequest, $1.Sequence>(
        'AddSequence',
        addSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AddSequenceRequest.fromBuffer(value),
        ($1.Sequence value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteSequenceRequest, $1.Sequences>(
        'DeleteSequence',
        deleteSequence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteSequenceRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SequenceGoRequest, $1.EmptyResponse>(
        'SequenceGo',
        sequenceGo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SequenceGoRequest.fromBuffer(value),
        ($1.EmptyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SequenceStopRequest, $1.EmptyResponse>(
        'SequenceStop',
        sequenceStop_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SequenceStopRequest.fromBuffer(value),
        ($1.EmptyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueTriggerRequest, $1.Sequences>(
        'UpdateCueTrigger',
        updateCueTrigger_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CueTriggerRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueTriggerTimeRequest, $1.Sequences>(
        'UpdateCueTriggerTime',
        updateCueTriggerTime_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CueTriggerTimeRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueNameRequest, $1.Sequences>(
        'UpdateCueName',
        updateCueName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CueNameRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueValueRequest, $1.Sequences>(
        'UpdateCueValue',
        updateCueValue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CueValueRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueTimingRequest, $1.Sequences>(
        'UpdateCueFadeTime',
        updateCueFadeTime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CueTimingRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueTimingRequest, $1.Sequences>(
        'UpdateCueDelayTime',
        updateCueDelayTime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CueTimingRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SequenceWrapAroundRequest, $1.Sequences>(
        'UpdateSequenceWrapAround',
        updateSequenceWrapAround_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SequenceWrapAroundRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CueNameRequest, $1.Sequences>(
        'UpdateSequenceName',
        updateSequenceName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CueNameRequest.fromBuffer(value),
        ($1.Sequences value) => value.writeToBuffer()));
  }

  $async.Future<$1.Sequences> getSequences_Pre($grpc.ServiceCall call,
      $async.Future<$1.GetSequencesRequest> request) async {
    return getSequences(call, await request);
  }

  $async.Future<$1.Sequence> getSequence_Pre($grpc.ServiceCall call,
      $async.Future<$1.GetSequenceRequest> request) async {
    return getSequence(call, await request);
  }

  $async.Future<$1.Sequence> addSequence_Pre($grpc.ServiceCall call,
      $async.Future<$1.AddSequenceRequest> request) async {
    return addSequence(call, await request);
  }

  $async.Future<$1.Sequences> deleteSequence_Pre($grpc.ServiceCall call,
      $async.Future<$1.DeleteSequenceRequest> request) async {
    return deleteSequence(call, await request);
  }

  $async.Future<$1.EmptyResponse> sequenceGo_Pre($grpc.ServiceCall call,
      $async.Future<$1.SequenceGoRequest> request) async {
    return sequenceGo(call, await request);
  }

  $async.Future<$1.EmptyResponse> sequenceStop_Pre($grpc.ServiceCall call,
      $async.Future<$1.SequenceStopRequest> request) async {
    return sequenceStop(call, await request);
  }

  $async.Future<$1.Sequences> updateCueTrigger_Pre($grpc.ServiceCall call,
      $async.Future<$1.CueTriggerRequest> request) async {
    return updateCueTrigger(call, await request);
  }

  $async.Future<$1.Sequences> updateCueTriggerTime_Pre($grpc.ServiceCall call,
      $async.Future<$1.CueTriggerTimeRequest> request) async {
    return updateCueTriggerTime(call, await request);
  }

  $async.Future<$1.Sequences> updateCueName_Pre(
      $grpc.ServiceCall call, $async.Future<$1.CueNameRequest> request) async {
    return updateCueName(call, await request);
  }

  $async.Future<$1.Sequences> updateCueValue_Pre(
      $grpc.ServiceCall call, $async.Future<$1.CueValueRequest> request) async {
    return updateCueValue(call, await request);
  }

  $async.Future<$1.Sequences> updateCueFadeTime_Pre($grpc.ServiceCall call,
      $async.Future<$1.CueTimingRequest> request) async {
    return updateCueFadeTime(call, await request);
  }

  $async.Future<$1.Sequences> updateCueDelayTime_Pre($grpc.ServiceCall call,
      $async.Future<$1.CueTimingRequest> request) async {
    return updateCueDelayTime(call, await request);
  }

  $async.Future<$1.Sequences> updateSequenceWrapAround_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SequenceWrapAroundRequest> request) async {
    return updateSequenceWrapAround(call, await request);
  }

  $async.Future<$1.Sequences> updateSequenceName_Pre(
      $grpc.ServiceCall call, $async.Future<$1.CueNameRequest> request) async {
    return updateSequenceName(call, await request);
  }

  $async.Future<$1.Sequences> getSequences(
      $grpc.ServiceCall call, $1.GetSequencesRequest request);
  $async.Future<$1.Sequence> getSequence(
      $grpc.ServiceCall call, $1.GetSequenceRequest request);
  $async.Future<$1.Sequence> addSequence(
      $grpc.ServiceCall call, $1.AddSequenceRequest request);
  $async.Future<$1.Sequences> deleteSequence(
      $grpc.ServiceCall call, $1.DeleteSequenceRequest request);
  $async.Future<$1.EmptyResponse> sequenceGo(
      $grpc.ServiceCall call, $1.SequenceGoRequest request);
  $async.Future<$1.EmptyResponse> sequenceStop(
      $grpc.ServiceCall call, $1.SequenceStopRequest request);
  $async.Future<$1.Sequences> updateCueTrigger(
      $grpc.ServiceCall call, $1.CueTriggerRequest request);
  $async.Future<$1.Sequences> updateCueTriggerTime(
      $grpc.ServiceCall call, $1.CueTriggerTimeRequest request);
  $async.Future<$1.Sequences> updateCueName(
      $grpc.ServiceCall call, $1.CueNameRequest request);
  $async.Future<$1.Sequences> updateCueValue(
      $grpc.ServiceCall call, $1.CueValueRequest request);
  $async.Future<$1.Sequences> updateCueFadeTime(
      $grpc.ServiceCall call, $1.CueTimingRequest request);
  $async.Future<$1.Sequences> updateCueDelayTime(
      $grpc.ServiceCall call, $1.CueTimingRequest request);
  $async.Future<$1.Sequences> updateSequenceWrapAround(
      $grpc.ServiceCall call, $1.SequenceWrapAroundRequest request);
  $async.Future<$1.Sequences> updateSequenceName(
      $grpc.ServiceCall call, $1.CueNameRequest request);
}

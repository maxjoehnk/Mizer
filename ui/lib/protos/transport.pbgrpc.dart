///
//  Generated code. Do not modify.
//  source: transport.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transport.pb.dart' as $0;
export 'transport.pb.dart';

class TransportApiClient extends $grpc.Client {
  static final _$subscribeTransport =
      $grpc.ClientMethod<$0.SubscribeTransportRequest, $0.Transport>(
          '/mizer.TransportApi/SubscribeTransport',
          ($0.SubscribeTransportRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Transport.fromBuffer(value));
  static final _$setState =
      $grpc.ClientMethod<$0.SetTransportRequest, $0.Transport>(
          '/mizer.TransportApi/SetState',
          ($0.SetTransportRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Transport.fromBuffer(value));
  static final _$setBpm = $grpc.ClientMethod<$0.SetBpmRequest, $0.Transport>(
      '/mizer.TransportApi/SetBpm',
      ($0.SetBpmRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Transport.fromBuffer(value));

  TransportApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Transport> subscribeTransport(
      $0.SubscribeTransportRequest request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$subscribeTransport, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Transport> setState($0.SetTransportRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$setState, request, options: options);
  }

  $grpc.ResponseFuture<$0.Transport> setBpm($0.SetBpmRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$setBpm, request, options: options);
  }
}

abstract class TransportApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.TransportApi';

  TransportApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SubscribeTransportRequest, $0.Transport>(
        'SubscribeTransport',
        subscribeTransport_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.SubscribeTransportRequest.fromBuffer(value),
        ($0.Transport value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetTransportRequest, $0.Transport>(
        'SetState',
        setState_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetTransportRequest.fromBuffer(value),
        ($0.Transport value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetBpmRequest, $0.Transport>(
        'SetBpm',
        setBpm_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetBpmRequest.fromBuffer(value),
        ($0.Transport value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Transport> subscribeTransport_Pre($grpc.ServiceCall call,
      $async.Future<$0.SubscribeTransportRequest> request) async* {
    yield* subscribeTransport(call, await request);
  }

  $async.Future<$0.Transport> setState_Pre($grpc.ServiceCall call,
      $async.Future<$0.SetTransportRequest> request) async {
    return setState(call, await request);
  }

  $async.Future<$0.Transport> setBpm_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SetBpmRequest> request) async {
    return setBpm(call, await request);
  }

  $async.Stream<$0.Transport> subscribeTransport(
      $grpc.ServiceCall call, $0.SubscribeTransportRequest request);
  $async.Future<$0.Transport> setState(
      $grpc.ServiceCall call, $0.SetTransportRequest request);
  $async.Future<$0.Transport> setBpm(
      $grpc.ServiceCall call, $0.SetBpmRequest request);
}

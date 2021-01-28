///
//  Generated code. Do not modify.
//  source: session.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'session.pb.dart' as $0;
export 'session.pb.dart';

class SessionApiClient extends $grpc.Client {
  static final _$getSession = $grpc.ClientMethod<$0.SessionRequest, $0.Session>(
      '/mizer.SessionApi/GetSession',
      ($0.SessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Session.fromBuffer(value));
  static final _$joinSession =
      $grpc.ClientMethod<$0.ClientAnnouncement, $0.Session>(
          '/mizer.SessionApi/JoinSession',
          ($0.ClientAnnouncement value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Session.fromBuffer(value));

  SessionApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Session> getSession($0.SessionRequest request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$getSession, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Session> joinSession($0.ClientAnnouncement request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$joinSession, request, options: options);
  }
}

abstract class SessionApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.SessionApi';

  SessionApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SessionRequest, $0.Session>(
        'GetSession',
        getSession_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SessionRequest.fromBuffer(value),
        ($0.Session value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ClientAnnouncement, $0.Session>(
        'JoinSession',
        joinSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ClientAnnouncement.fromBuffer(value),
        ($0.Session value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Session> getSession_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SessionRequest> request) async* {
    yield* getSession(call, await request);
  }

  $async.Future<$0.Session> joinSession_Pre($grpc.ServiceCall call,
      $async.Future<$0.ClientAnnouncement> request) async {
    return joinSession(call, await request);
  }

  $async.Stream<$0.Session> getSession(
      $grpc.ServiceCall call, $0.SessionRequest request);
  $async.Future<$0.Session> joinSession(
      $grpc.ServiceCall call, $0.ClientAnnouncement request);
}

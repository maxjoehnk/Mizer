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
  static final _$closeProject =
      $grpc.ClientMethod<$0.ProjectRequest, $0.ProjectResponse>(
          '/mizer.SessionApi/CloseProject',
          ($0.ProjectRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ProjectResponse.fromBuffer(value));
  static final _$newProject =
      $grpc.ClientMethod<$0.ProjectRequest, $0.ProjectResponse>(
          '/mizer.SessionApi/NewProject',
          ($0.ProjectRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ProjectResponse.fromBuffer(value));
  static final _$openProject =
      $grpc.ClientMethod<$0.OpenProjectRequest, $0.ProjectResponse>(
          '/mizer.SessionApi/OpenProject',
          ($0.OpenProjectRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ProjectResponse.fromBuffer(value));
  static final _$saveProject =
      $grpc.ClientMethod<$0.ProjectRequest, $0.ProjectResponse>(
          '/mizer.SessionApi/SaveProject',
          ($0.ProjectRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ProjectResponse.fromBuffer(value));

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

  $grpc.ResponseFuture<$0.ProjectResponse> closeProject(
      $0.ProjectRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$closeProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProjectResponse> newProject($0.ProjectRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$newProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProjectResponse> openProject(
      $0.OpenProjectRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$openProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.ProjectResponse> saveProject(
      $0.ProjectRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$saveProject, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.ProjectRequest, $0.ProjectResponse>(
        'CloseProject',
        closeProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProjectRequest.fromBuffer(value),
        ($0.ProjectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProjectRequest, $0.ProjectResponse>(
        'NewProject',
        newProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProjectRequest.fromBuffer(value),
        ($0.ProjectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OpenProjectRequest, $0.ProjectResponse>(
        'OpenProject',
        openProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.OpenProjectRequest.fromBuffer(value),
        ($0.ProjectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ProjectRequest, $0.ProjectResponse>(
        'SaveProject',
        saveProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ProjectRequest.fromBuffer(value),
        ($0.ProjectResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Session> getSession_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SessionRequest> request) async* {
    yield* getSession(call, await request);
  }

  $async.Future<$0.Session> joinSession_Pre($grpc.ServiceCall call,
      $async.Future<$0.ClientAnnouncement> request) async {
    return joinSession(call, await request);
  }

  $async.Future<$0.ProjectResponse> closeProject_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ProjectRequest> request) async {
    return closeProject(call, await request);
  }

  $async.Future<$0.ProjectResponse> newProject_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ProjectRequest> request) async {
    return newProject(call, await request);
  }

  $async.Future<$0.ProjectResponse> openProject_Pre($grpc.ServiceCall call,
      $async.Future<$0.OpenProjectRequest> request) async {
    return openProject(call, await request);
  }

  $async.Future<$0.ProjectResponse> saveProject_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ProjectRequest> request) async {
    return saveProject(call, await request);
  }

  $async.Stream<$0.Session> getSession(
      $grpc.ServiceCall call, $0.SessionRequest request);
  $async.Future<$0.Session> joinSession(
      $grpc.ServiceCall call, $0.ClientAnnouncement request);
  $async.Future<$0.ProjectResponse> closeProject(
      $grpc.ServiceCall call, $0.ProjectRequest request);
  $async.Future<$0.ProjectResponse> newProject(
      $grpc.ServiceCall call, $0.ProjectRequest request);
  $async.Future<$0.ProjectResponse> openProject(
      $grpc.ServiceCall call, $0.OpenProjectRequest request);
  $async.Future<$0.ProjectResponse> saveProject(
      $grpc.ServiceCall call, $0.ProjectRequest request);
}

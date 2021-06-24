///
//  Generated code. Do not modify.
//  source: connections.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'connections.pb.dart' as $0;
export 'connections.pb.dart';

class ConnectionsApiClient extends $grpc.Client {
  static final _$getConnections =
      $grpc.ClientMethod<$0.GetConnectionsRequest, $0.Connections>(
          '/mizer.ConnectionsApi/GetConnections',
          ($0.GetConnectionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Connections.fromBuffer(value));

  ConnectionsApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Connections> getConnections(
      $0.GetConnectionsRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getConnections, request, options: options);
  }
}

abstract class ConnectionsApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.ConnectionsApi';

  ConnectionsApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetConnectionsRequest, $0.Connections>(
        'GetConnections',
        getConnections_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetConnectionsRequest.fromBuffer(value),
        ($0.Connections value) => value.writeToBuffer()));
  }

  $async.Future<$0.Connections> getConnections_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetConnectionsRequest> request) async {
    return getConnections(call, await request);
  }

  $async.Future<$0.Connections> getConnections(
      $grpc.ServiceCall call, $0.GetConnectionsRequest request);
}

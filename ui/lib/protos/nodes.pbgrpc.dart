///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'nodes.pb.dart' as $0;
export 'nodes.pb.dart';

class NodesApiClient extends $grpc.Client {
  static final _$getNodes = $grpc.ClientMethod<$0.NodesRequest, $0.Nodes>(
      '/mizer.NodesApi/GetNodes',
      ($0.NodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Nodes.fromBuffer(value));

  NodesApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Nodes> getNodes($0.NodesRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getNodes, request, options: options);
  }
}

abstract class NodesApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.NodesApi';

  NodesApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NodesRequest, $0.Nodes>(
        'GetNodes',
        getNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NodesRequest.fromBuffer(value),
        ($0.Nodes value) => value.writeToBuffer()));
  }

  $async.Future<$0.Nodes> getNodes_Pre(
      $grpc.ServiceCall call, $async.Future<$0.NodesRequest> request) async {
    return getNodes(call, await request);
  }

  $async.Future<$0.Nodes> getNodes(
      $grpc.ServiceCall call, $0.NodesRequest request);
}

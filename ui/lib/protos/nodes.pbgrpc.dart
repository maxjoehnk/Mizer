///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
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
  static final _$addNode = $grpc.ClientMethod<$0.AddNodeRequest, $0.Node>(
      '/mizer.NodesApi/AddNode',
      ($0.AddNodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Node.fromBuffer(value));
  static final _$addLink =
      $grpc.ClientMethod<$0.NodeConnection, $0.NodeConnection>(
          '/mizer.NodesApi/AddLink',
          ($0.NodeConnection value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.NodeConnection.fromBuffer(value));
  static final _$writeControlValue =
      $grpc.ClientMethod<$0.WriteControl, $0.WriteResponse>(
          '/mizer.NodesApi/WriteControlValue',
          ($0.WriteControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.WriteResponse.fromBuffer(value));
  static final _$updateNodeProperty = $grpc.ClientMethod<
          $0.UpdateNodeConfigRequest, $0.UpdateNodeConfigResponse>(
      '/mizer.NodesApi/UpdateNodeProperty',
      ($0.UpdateNodeConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateNodeConfigResponse.fromBuffer(value));
  static final _$moveNode =
      $grpc.ClientMethod<$0.MoveNodeRequest, $0.MoveNodeResponse>(
          '/mizer.NodesApi/MoveNode',
          ($0.MoveNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MoveNodeResponse.fromBuffer(value));
  static final _$deleteNode =
      $grpc.ClientMethod<$0.DeleteNodeRequest, $0.DeleteNodeResponse>(
          '/mizer.NodesApi/DeleteNode',
          ($0.DeleteNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteNodeResponse.fromBuffer(value));

  NodesApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Nodes> getNodes($0.NodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodes, request, options: options);
  }

  $grpc.ResponseFuture<$0.Node> addNode($0.AddNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addNode, request, options: options);
  }

  $grpc.ResponseFuture<$0.NodeConnection> addLink($0.NodeConnection request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addLink, request, options: options);
  }

  $grpc.ResponseFuture<$0.WriteResponse> writeControlValue(
      $0.WriteControl request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$writeControlValue, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateNodeConfigResponse> updateNodeProperty(
      $0.UpdateNodeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNodeProperty, request, options: options);
  }

  $grpc.ResponseFuture<$0.MoveNodeResponse> moveNode($0.MoveNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveNode, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteNodeResponse> deleteNode(
      $0.DeleteNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteNode, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.AddNodeRequest, $0.Node>(
        'AddNode',
        addNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddNodeRequest.fromBuffer(value),
        ($0.Node value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.NodeConnection, $0.NodeConnection>(
        'AddLink',
        addLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NodeConnection.fromBuffer(value),
        ($0.NodeConnection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WriteControl, $0.WriteResponse>(
        'WriteControlValue',
        writeControlValue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WriteControl.fromBuffer(value),
        ($0.WriteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateNodeConfigRequest,
            $0.UpdateNodeConfigResponse>(
        'UpdateNodeProperty',
        updateNodeProperty_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateNodeConfigRequest.fromBuffer(value),
        ($0.UpdateNodeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MoveNodeRequest, $0.MoveNodeResponse>(
        'MoveNode',
        moveNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MoveNodeRequest.fromBuffer(value),
        ($0.MoveNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteNodeRequest, $0.DeleteNodeResponse>(
        'DeleteNode',
        deleteNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteNodeRequest.fromBuffer(value),
        ($0.DeleteNodeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Nodes> getNodes_Pre(
      $grpc.ServiceCall call, $async.Future<$0.NodesRequest> request) async {
    return getNodes(call, await request);
  }

  $async.Future<$0.Node> addNode_Pre(
      $grpc.ServiceCall call, $async.Future<$0.AddNodeRequest> request) async {
    return addNode(call, await request);
  }

  $async.Future<$0.NodeConnection> addLink_Pre(
      $grpc.ServiceCall call, $async.Future<$0.NodeConnection> request) async {
    return addLink(call, await request);
  }

  $async.Future<$0.WriteResponse> writeControlValue_Pre(
      $grpc.ServiceCall call, $async.Future<$0.WriteControl> request) async {
    return writeControlValue(call, await request);
  }

  $async.Future<$0.UpdateNodeConfigResponse> updateNodeProperty_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateNodeConfigRequest> request) async {
    return updateNodeProperty(call, await request);
  }

  $async.Future<$0.MoveNodeResponse> moveNode_Pre(
      $grpc.ServiceCall call, $async.Future<$0.MoveNodeRequest> request) async {
    return moveNode(call, await request);
  }

  $async.Future<$0.DeleteNodeResponse> deleteNode_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeleteNodeRequest> request) async {
    return deleteNode(call, await request);
  }

  $async.Future<$0.Nodes> getNodes(
      $grpc.ServiceCall call, $0.NodesRequest request);
  $async.Future<$0.Node> addNode(
      $grpc.ServiceCall call, $0.AddNodeRequest request);
  $async.Future<$0.NodeConnection> addLink(
      $grpc.ServiceCall call, $0.NodeConnection request);
  $async.Future<$0.WriteResponse> writeControlValue(
      $grpc.ServiceCall call, $0.WriteControl request);
  $async.Future<$0.UpdateNodeConfigResponse> updateNodeProperty(
      $grpc.ServiceCall call, $0.UpdateNodeConfigRequest request);
  $async.Future<$0.MoveNodeResponse> moveNode(
      $grpc.ServiceCall call, $0.MoveNodeRequest request);
  $async.Future<$0.DeleteNodeResponse> deleteNode(
      $grpc.ServiceCall call, $0.DeleteNodeRequest request);
}

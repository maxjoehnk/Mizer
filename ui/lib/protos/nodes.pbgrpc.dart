///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'nodes.pb.dart' as $2;
export 'nodes.pb.dart';

class NodesApiClient extends $grpc.Client {
  static final _$getNodes = $grpc.ClientMethod<$2.NodesRequest, $2.Nodes>(
      '/mizer.nodes.NodesApi/GetNodes',
      ($2.NodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Nodes.fromBuffer(value));
  static final _$addNode = $grpc.ClientMethod<$2.AddNodeRequest, $2.Node>(
      '/mizer.nodes.NodesApi/AddNode',
      ($2.AddNodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Node.fromBuffer(value));
  static final _$addLink =
      $grpc.ClientMethod<$2.NodeConnection, $2.NodeConnection>(
          '/mizer.nodes.NodesApi/AddLink',
          ($2.NodeConnection value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.NodeConnection.fromBuffer(value));
  static final _$writeControlValue =
      $grpc.ClientMethod<$2.WriteControl, $2.WriteResponse>(
          '/mizer.nodes.NodesApi/WriteControlValue',
          ($2.WriteControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.WriteResponse.fromBuffer(value));
  static final _$updateNodeProperty = $grpc.ClientMethod<
          $2.UpdateNodeConfigRequest, $2.UpdateNodeConfigResponse>(
      '/mizer.nodes.NodesApi/UpdateNodeProperty',
      ($2.UpdateNodeConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.UpdateNodeConfigResponse.fromBuffer(value));
  static final _$moveNode =
      $grpc.ClientMethod<$2.MoveNodeRequest, $2.MoveNodeResponse>(
          '/mizer.nodes.NodesApi/MoveNode',
          ($2.MoveNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.MoveNodeResponse.fromBuffer(value));
  static final _$deleteNode =
      $grpc.ClientMethod<$2.DeleteNodeRequest, $2.DeleteNodeResponse>(
          '/mizer.nodes.NodesApi/DeleteNode',
          ($2.DeleteNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.DeleteNodeResponse.fromBuffer(value));
  static final _$hideNode =
      $grpc.ClientMethod<$2.HideNodeRequest, $2.HideNodeResponse>(
          '/mizer.nodes.NodesApi/HideNode',
          ($2.HideNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.HideNodeResponse.fromBuffer(value));
  static final _$showNode =
      $grpc.ClientMethod<$2.ShowNodeRequest, $2.ShowNodeResponse>(
          '/mizer.nodes.NodesApi/ShowNode',
          ($2.ShowNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ShowNodeResponse.fromBuffer(value));
  static final _$duplicateNode =
      $grpc.ClientMethod<$2.DuplicateNodeRequest, $2.Node>(
          '/mizer.nodes.NodesApi/DuplicateNode',
          ($2.DuplicateNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.Node.fromBuffer(value));
  static final _$renameNode =
      $grpc.ClientMethod<$2.RenameNodeRequest, $2.RenameNodeResponse>(
          '/mizer.nodes.NodesApi/RenameNode',
          ($2.RenameNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.RenameNodeResponse.fromBuffer(value));
  static final _$groupNodes =
      $grpc.ClientMethod<$2.GroupNodesRequest, $2.GroupNodesResponse>(
          '/mizer.nodes.NodesApi/GroupNodes',
          ($2.GroupNodesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.GroupNodesResponse.fromBuffer(value));

  NodesApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.Nodes> getNodes($2.NodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodes, request, options: options);
  }

  $grpc.ResponseFuture<$2.Node> addNode($2.AddNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.NodeConnection> addLink($2.NodeConnection request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addLink, request, options: options);
  }

  $grpc.ResponseFuture<$2.WriteResponse> writeControlValue(
      $2.WriteControl request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$writeControlValue, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateNodeConfigResponse> updateNodeProperty(
      $2.UpdateNodeConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNodeProperty, request, options: options);
  }

  $grpc.ResponseFuture<$2.MoveNodeResponse> moveNode($2.MoveNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.DeleteNodeResponse> deleteNode(
      $2.DeleteNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.HideNodeResponse> hideNode($2.HideNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hideNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.ShowNodeResponse> showNode($2.ShowNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$showNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.Node> duplicateNode($2.DuplicateNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$duplicateNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.RenameNodeResponse> renameNode(
      $2.RenameNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameNode, request, options: options);
  }

  $grpc.ResponseFuture<$2.GroupNodesResponse> groupNodes(
      $2.GroupNodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$groupNodes, request, options: options);
  }
}

abstract class NodesApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.nodes.NodesApi';

  NodesApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.NodesRequest, $2.Nodes>(
        'GetNodes',
        getNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.NodesRequest.fromBuffer(value),
        ($2.Nodes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddNodeRequest, $2.Node>(
        'AddNode',
        addNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddNodeRequest.fromBuffer(value),
        ($2.Node value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.NodeConnection, $2.NodeConnection>(
        'AddLink',
        addLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.NodeConnection.fromBuffer(value),
        ($2.NodeConnection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.WriteControl, $2.WriteResponse>(
        'WriteControlValue',
        writeControlValue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.WriteControl.fromBuffer(value),
        ($2.WriteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateNodeConfigRequest,
            $2.UpdateNodeConfigResponse>(
        'UpdateNodeProperty',
        updateNodeProperty_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateNodeConfigRequest.fromBuffer(value),
        ($2.UpdateNodeConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.MoveNodeRequest, $2.MoveNodeResponse>(
        'MoveNode',
        moveNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.MoveNodeRequest.fromBuffer(value),
        ($2.MoveNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DeleteNodeRequest, $2.DeleteNodeResponse>(
        'DeleteNode',
        deleteNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.DeleteNodeRequest.fromBuffer(value),
        ($2.DeleteNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.HideNodeRequest, $2.HideNodeResponse>(
        'HideNode',
        hideNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.HideNodeRequest.fromBuffer(value),
        ($2.HideNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ShowNodeRequest, $2.ShowNodeResponse>(
        'ShowNode',
        showNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ShowNodeRequest.fromBuffer(value),
        ($2.ShowNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.DuplicateNodeRequest, $2.Node>(
        'DuplicateNode',
        duplicateNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.DuplicateNodeRequest.fromBuffer(value),
        ($2.Node value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RenameNodeRequest, $2.RenameNodeResponse>(
        'RenameNode',
        renameNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RenameNodeRequest.fromBuffer(value),
        ($2.RenameNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GroupNodesRequest, $2.GroupNodesResponse>(
        'GroupNodes',
        groupNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GroupNodesRequest.fromBuffer(value),
        ($2.GroupNodesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.Nodes> getNodes_Pre(
      $grpc.ServiceCall call, $async.Future<$2.NodesRequest> request) async {
    return getNodes(call, await request);
  }

  $async.Future<$2.Node> addNode_Pre(
      $grpc.ServiceCall call, $async.Future<$2.AddNodeRequest> request) async {
    return addNode(call, await request);
  }

  $async.Future<$2.NodeConnection> addLink_Pre(
      $grpc.ServiceCall call, $async.Future<$2.NodeConnection> request) async {
    return addLink(call, await request);
  }

  $async.Future<$2.WriteResponse> writeControlValue_Pre(
      $grpc.ServiceCall call, $async.Future<$2.WriteControl> request) async {
    return writeControlValue(call, await request);
  }

  $async.Future<$2.UpdateNodeConfigResponse> updateNodeProperty_Pre(
      $grpc.ServiceCall call,
      $async.Future<$2.UpdateNodeConfigRequest> request) async {
    return updateNodeProperty(call, await request);
  }

  $async.Future<$2.MoveNodeResponse> moveNode_Pre(
      $grpc.ServiceCall call, $async.Future<$2.MoveNodeRequest> request) async {
    return moveNode(call, await request);
  }

  $async.Future<$2.DeleteNodeResponse> deleteNode_Pre($grpc.ServiceCall call,
      $async.Future<$2.DeleteNodeRequest> request) async {
    return deleteNode(call, await request);
  }

  $async.Future<$2.HideNodeResponse> hideNode_Pre(
      $grpc.ServiceCall call, $async.Future<$2.HideNodeRequest> request) async {
    return hideNode(call, await request);
  }

  $async.Future<$2.ShowNodeResponse> showNode_Pre(
      $grpc.ServiceCall call, $async.Future<$2.ShowNodeRequest> request) async {
    return showNode(call, await request);
  }

  $async.Future<$2.Node> duplicateNode_Pre($grpc.ServiceCall call,
      $async.Future<$2.DuplicateNodeRequest> request) async {
    return duplicateNode(call, await request);
  }

  $async.Future<$2.RenameNodeResponse> renameNode_Pre($grpc.ServiceCall call,
      $async.Future<$2.RenameNodeRequest> request) async {
    return renameNode(call, await request);
  }

  $async.Future<$2.GroupNodesResponse> groupNodes_Pre($grpc.ServiceCall call,
      $async.Future<$2.GroupNodesRequest> request) async {
    return groupNodes(call, await request);
  }

  $async.Future<$2.Nodes> getNodes(
      $grpc.ServiceCall call, $2.NodesRequest request);
  $async.Future<$2.Node> addNode(
      $grpc.ServiceCall call, $2.AddNodeRequest request);
  $async.Future<$2.NodeConnection> addLink(
      $grpc.ServiceCall call, $2.NodeConnection request);
  $async.Future<$2.WriteResponse> writeControlValue(
      $grpc.ServiceCall call, $2.WriteControl request);
  $async.Future<$2.UpdateNodeConfigResponse> updateNodeProperty(
      $grpc.ServiceCall call, $2.UpdateNodeConfigRequest request);
  $async.Future<$2.MoveNodeResponse> moveNode(
      $grpc.ServiceCall call, $2.MoveNodeRequest request);
  $async.Future<$2.DeleteNodeResponse> deleteNode(
      $grpc.ServiceCall call, $2.DeleteNodeRequest request);
  $async.Future<$2.HideNodeResponse> hideNode(
      $grpc.ServiceCall call, $2.HideNodeRequest request);
  $async.Future<$2.ShowNodeResponse> showNode(
      $grpc.ServiceCall call, $2.ShowNodeRequest request);
  $async.Future<$2.Node> duplicateNode(
      $grpc.ServiceCall call, $2.DuplicateNodeRequest request);
  $async.Future<$2.RenameNodeResponse> renameNode(
      $grpc.ServiceCall call, $2.RenameNodeRequest request);
  $async.Future<$2.GroupNodesResponse> groupNodes(
      $grpc.ServiceCall call, $2.GroupNodesRequest request);
}

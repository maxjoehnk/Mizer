///
//  Generated code. Do not modify.
//  source: nodes.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'nodes.pb.dart' as $1;
export 'nodes.pb.dart';

class NodesApiClient extends $grpc.Client {
  static final _$getAvailableNodes =
      $grpc.ClientMethod<$1.NodesRequest, $1.AvailableNodes>(
          '/mizer.nodes.NodesApi/GetAvailableNodes',
          ($1.NodesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.AvailableNodes.fromBuffer(value));
  static final _$getNodes = $grpc.ClientMethod<$1.NodesRequest, $1.Nodes>(
      '/mizer.nodes.NodesApi/GetNodes',
      ($1.NodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Nodes.fromBuffer(value));
  static final _$addNode = $grpc.ClientMethod<$1.AddNodeRequest, $1.Node>(
      '/mizer.nodes.NodesApi/AddNode',
      ($1.AddNodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Node.fromBuffer(value));
  static final _$addLink =
      $grpc.ClientMethod<$1.NodeConnection, $1.NodeConnection>(
          '/mizer.nodes.NodesApi/AddLink',
          ($1.NodeConnection value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.NodeConnection.fromBuffer(value));
  static final _$writeControlValue =
      $grpc.ClientMethod<$1.WriteControl, $1.WriteResponse>(
          '/mizer.nodes.NodesApi/WriteControlValue',
          ($1.WriteControl value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.WriteResponse.fromBuffer(value));
  static final _$updateNodeSetting =
      $grpc.ClientMethod<$1.UpdateNodeSettingRequest, $1.Node>(
          '/mizer.nodes.NodesApi/UpdateNodeSetting',
          ($1.UpdateNodeSettingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Node.fromBuffer(value));
  static final _$moveNode =
      $grpc.ClientMethod<$1.MoveNodeRequest, $1.MoveNodeResponse>(
          '/mizer.nodes.NodesApi/MoveNode',
          ($1.MoveNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.MoveNodeResponse.fromBuffer(value));
  static final _$deleteNode =
      $grpc.ClientMethod<$1.DeleteNodeRequest, $1.DeleteNodeResponse>(
          '/mizer.nodes.NodesApi/DeleteNode',
          ($1.DeleteNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.DeleteNodeResponse.fromBuffer(value));
  static final _$hideNode =
      $grpc.ClientMethod<$1.HideNodeRequest, $1.HideNodeResponse>(
          '/mizer.nodes.NodesApi/HideNode',
          ($1.HideNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.HideNodeResponse.fromBuffer(value));
  static final _$showNode =
      $grpc.ClientMethod<$1.ShowNodeRequest, $1.ShowNodeResponse>(
          '/mizer.nodes.NodesApi/ShowNode',
          ($1.ShowNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ShowNodeResponse.fromBuffer(value));
  static final _$duplicateNode =
      $grpc.ClientMethod<$1.DuplicateNodeRequest, $1.Node>(
          '/mizer.nodes.NodesApi/DuplicateNode',
          ($1.DuplicateNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Node.fromBuffer(value));
  static final _$renameNode =
      $grpc.ClientMethod<$1.RenameNodeRequest, $1.RenameNodeResponse>(
          '/mizer.nodes.NodesApi/RenameNode',
          ($1.RenameNodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.RenameNodeResponse.fromBuffer(value));
  static final _$groupNodes =
      $grpc.ClientMethod<$1.GroupNodesRequest, $1.GroupNodesResponse>(
          '/mizer.nodes.NodesApi/GroupNodes',
          ($1.GroupNodesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GroupNodesResponse.fromBuffer(value));

  NodesApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.AvailableNodes> getAvailableNodes(
      $1.NodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAvailableNodes, request, options: options);
  }

  $grpc.ResponseFuture<$1.Nodes> getNodes($1.NodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodes, request, options: options);
  }

  $grpc.ResponseFuture<$1.Node> addNode($1.AddNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.NodeConnection> addLink($1.NodeConnection request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addLink, request, options: options);
  }

  $grpc.ResponseFuture<$1.WriteResponse> writeControlValue(
      $1.WriteControl request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$writeControlValue, request, options: options);
  }

  $grpc.ResponseFuture<$1.Node> updateNodeSetting(
      $1.UpdateNodeSettingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateNodeSetting, request, options: options);
  }

  $grpc.ResponseFuture<$1.MoveNodeResponse> moveNode($1.MoveNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$moveNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteNodeResponse> deleteNode(
      $1.DeleteNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.HideNodeResponse> hideNode($1.HideNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hideNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.ShowNodeResponse> showNode($1.ShowNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$showNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.Node> duplicateNode($1.DuplicateNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$duplicateNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.RenameNodeResponse> renameNode(
      $1.RenameNodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$renameNode, request, options: options);
  }

  $grpc.ResponseFuture<$1.GroupNodesResponse> groupNodes(
      $1.GroupNodesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$groupNodes, request, options: options);
  }
}

abstract class NodesApiServiceBase extends $grpc.Service {
  $core.String get $name => 'mizer.nodes.NodesApi';

  NodesApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.NodesRequest, $1.AvailableNodes>(
        'GetAvailableNodes',
        getAvailableNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NodesRequest.fromBuffer(value),
        ($1.AvailableNodes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.NodesRequest, $1.Nodes>(
        'GetNodes',
        getNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NodesRequest.fromBuffer(value),
        ($1.Nodes value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AddNodeRequest, $1.Node>(
        'AddNode',
        addNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AddNodeRequest.fromBuffer(value),
        ($1.Node value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.NodeConnection, $1.NodeConnection>(
        'AddLink',
        addLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NodeConnection.fromBuffer(value),
        ($1.NodeConnection value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.WriteControl, $1.WriteResponse>(
        'WriteControlValue',
        writeControlValue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.WriteControl.fromBuffer(value),
        ($1.WriteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateNodeSettingRequest, $1.Node>(
        'UpdateNodeSetting',
        updateNodeSetting_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateNodeSettingRequest.fromBuffer(value),
        ($1.Node value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MoveNodeRequest, $1.MoveNodeResponse>(
        'MoveNode',
        moveNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.MoveNodeRequest.fromBuffer(value),
        ($1.MoveNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteNodeRequest, $1.DeleteNodeResponse>(
        'DeleteNode',
        deleteNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DeleteNodeRequest.fromBuffer(value),
        ($1.DeleteNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.HideNodeRequest, $1.HideNodeResponse>(
        'HideNode',
        hideNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.HideNodeRequest.fromBuffer(value),
        ($1.HideNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ShowNodeRequest, $1.ShowNodeResponse>(
        'ShowNode',
        showNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ShowNodeRequest.fromBuffer(value),
        ($1.ShowNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DuplicateNodeRequest, $1.Node>(
        'DuplicateNode',
        duplicateNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DuplicateNodeRequest.fromBuffer(value),
        ($1.Node value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RenameNodeRequest, $1.RenameNodeResponse>(
        'RenameNode',
        renameNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RenameNodeRequest.fromBuffer(value),
        ($1.RenameNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GroupNodesRequest, $1.GroupNodesResponse>(
        'GroupNodes',
        groupNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GroupNodesRequest.fromBuffer(value),
        ($1.GroupNodesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.AvailableNodes> getAvailableNodes_Pre(
      $grpc.ServiceCall call, $async.Future<$1.NodesRequest> request) async {
    return getAvailableNodes(call, await request);
  }

  $async.Future<$1.Nodes> getNodes_Pre(
      $grpc.ServiceCall call, $async.Future<$1.NodesRequest> request) async {
    return getNodes(call, await request);
  }

  $async.Future<$1.Node> addNode_Pre(
      $grpc.ServiceCall call, $async.Future<$1.AddNodeRequest> request) async {
    return addNode(call, await request);
  }

  $async.Future<$1.NodeConnection> addLink_Pre(
      $grpc.ServiceCall call, $async.Future<$1.NodeConnection> request) async {
    return addLink(call, await request);
  }

  $async.Future<$1.WriteResponse> writeControlValue_Pre(
      $grpc.ServiceCall call, $async.Future<$1.WriteControl> request) async {
    return writeControlValue(call, await request);
  }

  $async.Future<$1.Node> updateNodeSetting_Pre($grpc.ServiceCall call,
      $async.Future<$1.UpdateNodeSettingRequest> request) async {
    return updateNodeSetting(call, await request);
  }

  $async.Future<$1.MoveNodeResponse> moveNode_Pre(
      $grpc.ServiceCall call, $async.Future<$1.MoveNodeRequest> request) async {
    return moveNode(call, await request);
  }

  $async.Future<$1.DeleteNodeResponse> deleteNode_Pre($grpc.ServiceCall call,
      $async.Future<$1.DeleteNodeRequest> request) async {
    return deleteNode(call, await request);
  }

  $async.Future<$1.HideNodeResponse> hideNode_Pre(
      $grpc.ServiceCall call, $async.Future<$1.HideNodeRequest> request) async {
    return hideNode(call, await request);
  }

  $async.Future<$1.ShowNodeResponse> showNode_Pre(
      $grpc.ServiceCall call, $async.Future<$1.ShowNodeRequest> request) async {
    return showNode(call, await request);
  }

  $async.Future<$1.Node> duplicateNode_Pre($grpc.ServiceCall call,
      $async.Future<$1.DuplicateNodeRequest> request) async {
    return duplicateNode(call, await request);
  }

  $async.Future<$1.RenameNodeResponse> renameNode_Pre($grpc.ServiceCall call,
      $async.Future<$1.RenameNodeRequest> request) async {
    return renameNode(call, await request);
  }

  $async.Future<$1.GroupNodesResponse> groupNodes_Pre($grpc.ServiceCall call,
      $async.Future<$1.GroupNodesRequest> request) async {
    return groupNodes(call, await request);
  }

  $async.Future<$1.AvailableNodes> getAvailableNodes(
      $grpc.ServiceCall call, $1.NodesRequest request);
  $async.Future<$1.Nodes> getNodes(
      $grpc.ServiceCall call, $1.NodesRequest request);
  $async.Future<$1.Node> addNode(
      $grpc.ServiceCall call, $1.AddNodeRequest request);
  $async.Future<$1.NodeConnection> addLink(
      $grpc.ServiceCall call, $1.NodeConnection request);
  $async.Future<$1.WriteResponse> writeControlValue(
      $grpc.ServiceCall call, $1.WriteControl request);
  $async.Future<$1.Node> updateNodeSetting(
      $grpc.ServiceCall call, $1.UpdateNodeSettingRequest request);
  $async.Future<$1.MoveNodeResponse> moveNode(
      $grpc.ServiceCall call, $1.MoveNodeRequest request);
  $async.Future<$1.DeleteNodeResponse> deleteNode(
      $grpc.ServiceCall call, $1.DeleteNodeRequest request);
  $async.Future<$1.HideNodeResponse> hideNode(
      $grpc.ServiceCall call, $1.HideNodeRequest request);
  $async.Future<$1.ShowNodeResponse> showNode(
      $grpc.ServiceCall call, $1.ShowNodeRequest request);
  $async.Future<$1.Node> duplicateNode(
      $grpc.ServiceCall call, $1.DuplicateNodeRequest request);
  $async.Future<$1.RenameNodeResponse> renameNode(
      $grpc.ServiceCall call, $1.RenameNodeRequest request);
  $async.Future<$1.GroupNodesResponse> groupNodes(
      $grpc.ServiceCall call, $1.GroupNodesRequest request);
}

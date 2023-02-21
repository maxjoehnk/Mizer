import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';
import 'ffi/history.dart';
import 'ffi/preview.dart';

export 'ffi/preview.dart' show NodePreviewPointer;
export 'ffi/history.dart' show NodeHistoryPointer;

class NodesPluginApi implements NodesApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/nodes");

  NodesPluginApi(this.bindings);

  @override
  Future<Node> addNode(AddNodeRequest request) async {
    var response = await channel.invokeMethod("addNode", request.writeToBuffer());

    return Node.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Nodes> getNodes() async {
    var response = await channel.invokeMethod("getNodes");

    return Nodes.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> linkNodes(NodeConnection connection) {
    return channel.invokeMethod("linkNodes", connection.writeToBuffer());
  }

  @override
  Future<void> unlinkNodes(NodeConnection connection) {
    return channel.invokeMethod("unlinkNodes", connection.writeToBuffer());
  }

  @override
  Future<void> writeControlValue({required String path, required String port, required double value}) {
    return channel.invokeMethod(
        "writeControlValue", WriteControl(path: path, port: port, value: value).writeToBuffer());
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> updateNodeConfig(UpdateNodeConfigRequest request) {
    return channel.invokeMethod("updateNodeProperty", request.writeToBuffer());
  }

  @override
  Future<void> moveNode(MoveNodeRequest request) {
    return channel.invokeMethod("moveNode", request.writeToBuffer());
  }

  @override
  Future<void> deleteNode(String path) {
    return channel.invokeMethod("deleteNode", path);
  }

  Future<NodeHistoryPointer> getHistoryPointer(String path) async {
    int pointer = await channel.invokeMethod("getHistoryPointer", path);

    return this.bindings.openNodeHistory(pointer);
  }

  Future<NodePreviewPointer> getPreviewPointer(String path) async {
    int pointer = await channel.invokeMethod("getPreviewPointer", path);

    return this.bindings.openNodePreview(pointer);
  }

  @override
  Future<void> showNode(ShowNodeRequest request) async {
    await channel.invokeMethod("showNode", request.writeToBuffer());
  }

  @override
  Future<void> hideNode(String path) async {
    await channel.invokeMethod("hideNode", path);
  }

  @override
  Future<void> disconnectPorts(String path) async {
    await channel.invokeMethod("disconnectPorts", path);
  }

  @override
  Future<void> duplicateNode(DuplicateNodeRequest request) async {
    await channel.invokeMethod("duplicateNode", request.writeToBuffer());
  }

  @override
  Future<void> renameNode(RenameNodeRequest request) async {
    await channel.invokeMethod("renameNode", request.writeToBuffer());
  }

  @override
  Future<void> groupNodes(List<String> nodes, {String? parent}) async {
    var request = GroupNodesRequest(nodes: nodes, parent: parent);
    await channel.invokeMethod("groupNodes", request.writeToBuffer());
  }
}

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'package:mizer/api/plugin/ffi/api.dart';
import 'package:mizer/api/plugin/ffi/bindings.dart';
import 'package:mizer/api/plugin/ffi/history.dart';
import 'package:mizer/api/plugin/ffi/nodes.dart';

export 'ffi/history.dart' show NodeHistoryPointer;

class NodesPluginApi implements NodesApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/nodes");
  final EventChannel settings = const EventChannel("mizer.live/nodes/settings");

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
  Future<List<AvailableNode>> getAvailableNodes() async {
    var response = await channel.invokeMethod("getAvailableNodes");

    return AvailableNodes.fromBuffer(_convertBuffer(response)).nodes;
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
  Future<void> writeControlValue(
      {required String path, required String port, required double value}) {
    return channel.invokeMethod(
        "writeControlValue", WriteControl(path: path, port: port, value: value).writeToBuffer());
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> updateNodeSetting(UpdateNodeSettingRequest request) {
    return channel.invokeMethod("updateNodeSetting", request.writeToBuffer());
  }

  @override
  Future<void> updateNodeColor(UpdateNodeColorRequest request) {
    return channel.invokeMethod("updateNodeColor", request.writeToBuffer());
  }

  @override
  Future<void> moveNodes(MoveNodesRequest request) {
    return channel.invokeMethod("moveNodes", request.writeToBuffer());
  }

  @override
  Future<void> deleteNodes(List<String> paths) {
    return channel.invokeMethod("deleteNodes", paths);
  }

  Future<NodeHistoryPointer> getHistoryPointer(String path) async {
    int pointer = await channel.invokeMethod("getHistoryPointer", path);

    return this.bindings.openNodeHistory(pointer);
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
  Future<void> disconnectPort(String path, String port) async {
    var request = DisconnectPortRequest(path: path, port: port);

    await channel.invokeMethod("disconnectPort", request.writeToBuffer());
  }

  @override
  Future<List<String>> duplicateNodes(DuplicateNodesRequest request) async {
    List<Object?> response = await channel.invokeMethod("duplicateNodes", request.writeToBuffer());

    return response.map((e) => e as String).toList();
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

  @override
  Future<NodesPointer> getNodesPointer() async {
    int pointer = await channel.invokeMethod("getMetadataPointer");

    return this.bindings.openNodesRef(pointer);
  }

  @override
  Future<void> closeNodesView() async {
    await channel.invokeMethod("closeNodesView");
  }

  @override
  Future<void> openNodesView() async {
    await channel.invokeMethod("openNodesView");
  }

  @override
  Future<void> openNodeSettings(List<String> paths) async {
    await channel.invokeMethod("openNodeSettings", paths);
  }

  @override
  Stream<List<NodeSetting>> nodeSettings(String path) {
    return settings
        .receiveBroadcastStream(path)
        .map((buffer) => NodeSettings.fromBuffer(_convertBuffer(buffer)).settings);
  }
}

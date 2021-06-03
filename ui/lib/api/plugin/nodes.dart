import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

class NodesPluginApi implements NodesApi {
  final MethodChannel channel = const MethodChannel("mizer.live/nodes");

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
  Future<void> writeControlValue({String path, String port, double value}) {
    return channel.invokeMethod(
        "writeControlValue", WriteControl(path: path, port: port, value: value).writeToBuffer());
  }

  @override
  Future<List<double>> getNodeHistory(String path) {
    return channel.invokeListMethod(
        "getNodeHistory",
        path
    );
  }

  @override
  Future<Map<String, List<double>>> getNodeHistories(List<String> paths) async {
    Map<String, List<dynamic>> result = await channel.invokeMapMethod(
      "getNodeHistories",
      paths
    );
    Map<String, List<double>> map = result.map((key, value) => MapEntry(key, value.map((dynamic e) => e as double).toList()));
    return map;
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}

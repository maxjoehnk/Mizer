import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/ports.dart';
import 'package:mizer/protos/ports.pb.dart';

class PortsPluginApi implements PortsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/ports");

  @override
  Future<List<NodePort>> getPorts() async {
    var response = await channel.invokeMethod("getPorts");

    return NodePorts.fromBuffer(_convertBuffer(response)).ports;
  }

  @override
  Future<NodePort> addPort({ String? name }) async {
    var response = await channel.invokeMethod("addPort", name);

    return NodePort.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> deletePort(int id) async {
    await channel.invokeMethod("deletePort", id);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';

class ConnectionsPluginApi implements ConnectionsApi {
  final MethodChannel channel = const MethodChannel("mizer.live/connections");

  @override
  Future<Connections> getConnections() async {
    var response = await channel.invokeMethod("getConnections");

    return Connections.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Map<int, List<int>>> monitorDmxConnection(String outputId) async {
    Map<dynamic, dynamic> response = await channel.invokeMethod("monitorDmx", outputId);

    return response.map((dynamic key, dynamic value) => MapEntry(key as int, (value as List<dynamic>).map((dynamic e) => e as int).toList()));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';
import 'ffi/connections.dart';

class ConnectionsPluginApi implements ConnectionsApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/connections");
  final EventChannel midiMonitorChannel = const EventChannel("mizer.live/connections/midi");
  final EventChannel oscMonitorChannel = const EventChannel("mizer.live/connections/osc");
  ConnectionsPointer? _connectionsPointer;

  ConnectionsPluginApi(this.bindings) {
    _openConnectionsRef();
  }

  void _openConnectionsRef() async {
    int pointer = await channel.invokeMethod("getConnectionsRef");
    _connectionsPointer = bindings.openConnectionsRef(pointer);
  }

  @override
  Future<Connections> getConnections() async {
    var response = await channel.invokeMethod("getConnections");

    return Connections.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Map<int, List<int>>> monitorDmxConnection(String outputId) async {
    Map<dynamic, dynamic> response = await channel.invokeMethod("monitorDmx", outputId);

    return response.map((dynamic key, dynamic value) =>
        MapEntry(key as int, (value as List<dynamic>).map((dynamic e) => e as int).toList()));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> addArtnet(ArtnetConfig request) async {
    await channel.invokeMethod("addArtnet", request.writeToBuffer());
  }

  @override
  Future<void> addSacn(SacnConfig request) async {
    await channel.invokeMethod("addSacn", request.writeToBuffer());
  }

  @override
  Future<void> addMqtt(MqttConnection request) async {
    await channel.invokeMethod("addMqtt", request.writeToBuffer());
  }

  @override
  Future<void> addOsc(OscConnection request) async {
    await channel.invokeMethod("addOsc", request.writeToBuffer());
  }

  @override
  Future<MidiDeviceProfiles> getMidiDeviceProfiles() async {
    var response = await channel.invokeMethod("getMidiDeviceProfiles");

    return MidiDeviceProfiles.fromBuffer(_convertBuffer(response));
  }

  @override
  Stream<MonitorMidiResponse> monitorMidiConnection(String connectionId) {
    return midiMonitorChannel
        .receiveBroadcastStream(connectionId)
        .map((buffer) => MonitorMidiResponse.fromBuffer(_convertBuffer(buffer)));
  }

  @override
  Stream<MonitorOscResponse> monitorOscConnection(String connectionId) {
    return oscMonitorChannel
        .receiveBroadcastStream(connectionId)
        .map((buffer) => MonitorOscResponse.fromBuffer(_convertBuffer(buffer)));
  }

  @override
  Future<void> deleteConnection(Connection connection) async {
    await channel.invokeMethod("deleteConnection", connection.writeToBuffer());
  }

  @override
  Future<void> configureConnection(ConfigureConnectionRequest request) async {
    await channel.invokeMethod("configureConnection", request.writeToBuffer());
  }

  @override
  Future<GamepadStatePointer?> getGamepadPointer(String id) async {
    int pointer = await channel.invokeMethod("getGamepadPointer", id);

    return this.bindings.openGamepadRef(pointer);
  }

  @override
  PioneerCdjConnection? getCdjState(String id) {
    return this._connectionsPointer?.readCdjState(id);
  }
}

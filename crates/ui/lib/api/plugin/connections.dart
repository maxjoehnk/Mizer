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
    return Connections(connections: [
      Connection(
          name: "dmx-0",
          dmxOutput: DmxOutputConnection(
              outputId: "dmx-0",
              sacn: SacnConfig(
                name: "dmx-0",
                priority: 100,
              ))),
      Connection(
          name: "dmx-1",
          dmxOutput: DmxOutputConnection(
              outputId: "dmx-1",
              artnet: ArtnetOutputConfig(
                name: "dmx-1",
                host: "192.168.0.1",
                port: 6454,
              ))),
      Connection(
          name: "dmx-input-0",
          dmxInput: DmxInputConnection(
              id: "dmx-input-0",
              artnet: ArtnetInputConfig(
                name: "dmx-input-0",
                host: "0.0.0.0",
                port: 6454,
              ))),
      Connection(
          name: "Midi Controller",
        midi: MidiConnection()
      ),
      Connection(
          name: "MQTT",
          mqtt: MqttConnection(
            connectionId: "mqtt-0",
            url: "mqtt://mqtt.infra.maxjoehnk.me"
          )
      ),
      Connection(
          name: "OSC",
          osc: OscConnection(
            connectionId: "osc-0",
            inputPort: 8000,
            outputPort: 8001,
            outputAddress: "192.168.1.10"
          )
      ),
      Connection(
          name: "Helios 1",
          helios: HeliosConnection(
            name: "Helios",
            firmware: 1,
          )
      ),
      Connection(
          name: "EtherDream 1",
          etherDream: EtherDreamConnection(name: "Name")
      ),
      Connection(
          name: "Gamepad",
          gamepad: GamepadConnection(
            name: "Gamepad",
            id: "gamepad-0"
          )
      ),
      Connection(
          name: "G13",
          g13: G13Connection(id: "g13-0")
      ),
      Connection(
          name: "CDJ Nexus 2000",
          cdj: PioneerCdjConnection(
            id: "cdj-0",
            address: "0.0.0.0",
            model: "CDJ Nexus 2000",
            playerNumber: 1,
            playback: CdjPlayback(live: true, bpm: 170, frame: 1, playback: CdjPlayback_State.PLAYING, track: CdjPlayback_Track(
              artist: "Darren Styles",
              title: "Satellite",
            )),
          )
      ),
      Connection(
          name: "CDJ Nexus 2000",
          cdj: PioneerCdjConnection(
            id: "cdj-1",
            address: "0.0.0.0",
            model: "CDJ Nexus 2000",
            playerNumber: 2,
            playback: CdjPlayback(live: true, bpm: 170, frame: 2, playback: CdjPlayback_State.CUED, track: CdjPlayback_Track(
              artist: "Gammer",
              title: "The Drop",
            )),
          )
      ),
      Connection(
        name: "DJM 900",
        djm: PioneerDjmConnection(
          id: "djm-0",
          address: "0.0.0.0",
          model: "DJM-900",
          playerNumber: 0,
        )
      ),
      Connection(
          name: "FaceTime Cam",
          webcam: WebcamConnection(
            id: "webcam-0",
            name: "FaceTime Cam"
          )
      ),
      Connection(
          name: "Screen Mirror (MAKSBOOK-PRO)",
          ndiSource: NdiSourceConnection(
            id: "ndi-0",
            name: "Screen Mirror (MAKSBOOK-PRO)",
          )
      ),
      Connection(
        name: "Capture",
        citp: CitpConnection(
          connectionId: "citp-0",
          name: "Citp",
          kind: CitpConnection_CitpKind.CITP_KIND_VISUALIZER,
          state: "Connected"
        )
      )
    ]);


    var response = await channel.invokeMethod("getConnections");

    return Connections.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Map<int, List<int>>> monitorDmxOutput() async {
    Map<dynamic, dynamic> response = await channel.invokeMethod("monitorDmx");

    return response.map((dynamic key, dynamic value) =>
        MapEntry(key as int, (value as List<dynamic>).map((dynamic e) => e as int).toList()));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> addArtnetOutput(ArtnetOutputConfig request) async {
    await channel.invokeMethod("addArtnetOutput", request.writeToBuffer());
  }

  @override
  Future<void> addArtnetInput(ArtnetInputConfig request) async {
    await channel.invokeMethod("addArtnetInput", request.writeToBuffer());
  }

  @override
  Future<void> addSacnOutput(SacnConfig request) async {
    await channel.invokeMethod("addSacnOutput", request.writeToBuffer());
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

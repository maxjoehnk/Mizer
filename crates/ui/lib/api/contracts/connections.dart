import 'package:mizer/api/plugin/ffi/connections.dart';
import 'package:mizer/protos/connections.pb.dart';

abstract class ConnectionsApi {
  Future<Connections> getConnections();

  Future<void> addArtnetOutput(ArtnetOutputConfig request);
  Future<void> addArtnetInput(ArtnetInputConfig request);
  Future<void> addSacnOutput(SacnConfig request);
  Future<void> addMqtt(MqttConnection request);
  Future<void> addOsc(OscConnection request);

  Future<Map<int, List<int>>> monitorDmxOutput();
  Stream<MonitorMidiResponse> monitorMidiConnection(String connectionId);
  Stream<MonitorOscResponse> monitorOscConnection(String connectionId);

  Future<void> changeMidiDeviceProfile(String connectionId, String profileId);
  Future<MidiDeviceProfiles> getMidiDeviceProfiles();

  Future<void> deleteConnection(Connection connection);
  Future<void> configureConnection(ConfigureConnectionRequest request);

  Future<GamepadStatePointer?> getGamepadPointer(String id);
  PioneerCdjConnection? getCdjState(String id);
  Future<ConnectionsPointer> getConnectionsPointer();
}

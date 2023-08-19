import 'package:mizer/api/plugin/ffi/connections.dart';
import 'package:mizer/protos/connections.pb.dart';

abstract class ConnectionsApi {
  Future<Connections> getConnections();

  Future<void> addArtnet(ArtnetConfig request);
  Future<void> addSacn(SacnConfig request);
  Future<void> addMqtt(MqttConnection request);
  Future<void> addOsc(OscConnection request);

  Future<Map<int, List<int>>> monitorDmxConnection(String outputId);
  Stream<MonitorMidiResponse> monitorMidiConnection(String connectionId);
  Stream<MonitorOscResponse> monitorOscConnection(String connectionId);

  Future<MidiDeviceProfiles> getMidiDeviceProfiles();

  Future<void> deleteConnection(Connection connection);
  Future<void> configureConnection(ConfigureConnectionRequest request);

  Future<GamepadStatePointer?> getGamepadPointer(String id);
  PioneerCdjConnection? getCdjState(String id);
}

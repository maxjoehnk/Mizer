import 'package:mizer/protos/connections.pb.dart';

abstract class ConnectionsApi {
  Future<Connections> getConnections();

  Future<void> addArtnet(ArtnetConfig request);
  Future<void> addSacn(SacnConfig request);
  Future<void> addMqtt(MqttConnection request);

  Future<Map<int, List<int>>> monitorDmxConnection(String outputId);
  Stream<MonitorMidiResponse> monitorMidiConnection(String connectionId);

  Future<MidiDeviceProfiles> getMidiDeviceProfiles();

  Future<void> deleteConnection(Connection connection);
  Future<void> configureConnection(ConfigureConnectionRequest request);
}

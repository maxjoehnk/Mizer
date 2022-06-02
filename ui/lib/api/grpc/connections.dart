import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pbgrpc.dart';

class ConnectionsGrpcApi implements ConnectionsApi {
  final ConnectionsApiClient client;

  ConnectionsGrpcApi(ClientChannel channel) : client = ConnectionsApiClient(channel);

  @override
  Future<Connections> getConnections() {
    return client.getConnections(GetConnectionsRequest());
  }

  @override
  Future<Map<int, List<int>>> monitorDmxConnection(String outputId) async {
    var res = await this.client.monitorDmx(MonitorDmxRequest(outputId: outputId));
    return res.universes.asMap()
        .map((_, universe) => MapEntry(universe.universe, universe.channels));
  }

  @override
  Future<void> addArtnet(ArtnetConfig request) async {
    await this.client.addArtnetConnection(request);
  }

  @override
  Future<void> addSacn(SacnConfig request) async {
    await this.client.addSacnConnection(request);
  }

  @override
  Future<MidiDeviceProfiles> getMidiDeviceProfiles() {
    return this.client.getMidiDeviceProfiles(GetDeviceProfilesRequest());
  }

  @override
  Stream<MonitorMidiResponse> monitorMidiConnection(String connectionId) {
    return this.client.monitorMidi(MonitorMidiRequest(name: connectionId));
  }

  @override
  Future<void> deleteConnection(Connection connection) async {
    await this.client.deleteConnection(connection);
  }

  @override
  Future<void> configureConnection(ConfigureConnectionRequest request) async {
    await this.client.configureConnection(request);
  }
}

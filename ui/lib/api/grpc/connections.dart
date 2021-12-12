import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
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
  Future<void> addArtnet(AddArtnetRequest request) async {
    await this.client.addArtnetConnection(request);
  }

  @override
  Future<void> addSacn(AddSacnRequest request) async {
    await this.client.addSacnConnection(request);
  }
}

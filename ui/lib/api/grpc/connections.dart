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
}

import 'package:mizer/protos/connections.pb.dart';

abstract class ConnectionsApi {
  Future<Connections> getConnections();

  Future<Map<int, List<int>>> monitorDmxConnection(String outputId);
}

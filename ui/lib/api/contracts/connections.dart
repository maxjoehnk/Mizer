import 'package:mizer/protos/connections.pb.dart';

abstract class ConnectionsApi {
  Future<Connections> getConnections();

  Future<void> addArtnet(AddArtnetRequest request);

  Future<void> addSacn(AddSacnRequest request);

  Future<Map<int, List<int>>> monitorDmxConnection(String outputId);
}

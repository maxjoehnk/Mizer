import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesApi {
  Future<Nodes> getNodes();

  Future<Node> addNode(AddNodeRequest request);

  Future<void> linkNodes(NodeConnection connection);

  Future<void> writeControlValue({ required String path, required String port, required double value });

  Future<void> updateNodeConfig(UpdateNodeConfigRequest request);

  Future<void> moveNode(MoveNodeRequest request);

  Future<void> deleteNode(String path);

  Future<void> hideNode(String path);

  Future<void> showNode(ShowNodeRequest request);
}

import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesApi {
  Future<Nodes> getNodes();

  Future<Node> addNode(AddNodeRequest request);

  Future<void> linkNodes(NodeConnection connection);

  Future<void> writeControlValue({ String path, String port, double value });

  Future<void> updateNodeConfig(UpdateNodeConfigRequest request);

  Future<void> moveNode(MoveNodeRequest request);

  Future<void> deleteNode(String path);
}

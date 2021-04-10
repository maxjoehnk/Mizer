import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesApi {
  Future<Nodes> getNodes();

  Future<Node> addNode(AddNodeRequest request);

  Future<void> linkNodes(NodeConnection connection);

  Future<void> writeControlValue({ String path, String port, double value });
}

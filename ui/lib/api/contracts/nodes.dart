import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesApi {
  Future<Nodes> getNodes();

  Future<Node> addNode(AddNodeRequest request);

  Future<void> linkNodes(NodeConnection connection);

  Future<void> writeControlValue({ String path, String port, double value });

  Future<List<double>> getNodeHistory(String path);

  Future<Map<String, List<double>>> getNodeHistories(List<String> paths);
}

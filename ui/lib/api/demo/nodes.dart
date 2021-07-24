import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

class NodesDemoApi implements NodesApi {
  @override
  Future<Node> addNode(AddNodeRequest request) {
    // TODO: implement addNode
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<double>>> getNodeHistories(List<String> paths) {
    // TODO: implement getNodeHistories
    throw UnimplementedError();
  }

  @override
  Future<List<double>> getNodeHistory(String path) {
    // TODO: implement getNodeHistory
    throw UnimplementedError();
  }

  @override
  Future<Nodes> getNodes() async {
    return Nodes(nodes: [
      Node(
        type: Node_NodeType.DmxOutput,
        path: '/dmx-output-0',
        config: NodeConfig(dmxOutputConfig: DmxOutputNodeConfig()),
        designer: NodeDesigner(
          position: NodePosition(x: 0, y: 0),
          scale: 1
        ),
        preview: Node_NodePreviewType.None,
      )
    ]);
  }

  @override
  Future<void> linkNodes(NodeConnection connection) {
    // TODO: implement linkNodes
    throw UnimplementedError();
  }

  @override
  Future<void> updateNodeConfig(UpdateNodeConfigRequest request) {
    // TODO: implement updateNodeConfig
    throw UnimplementedError();
  }

  @override
  Future<void> writeControlValue({String path, String port, double value}) {
    // TODO: implement writeControlValue
    throw UnimplementedError();
  }

  @override
  Future<void> moveNode(MoveNodeRequest request) {
    // TODO: implement moveNode
    throw UnimplementedError();
  }
}

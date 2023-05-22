import 'package:mizer/api/plugin/ffi/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesApi {
  Future<Nodes> getNodes();

  Future<Node> addNode(AddNodeRequest request);

  Future<void> linkNodes(NodeConnection connection);
  Future<void> unlinkNodes(NodeConnection connection);

  Future<void> writeControlValue(
      {required String path, required String port, required double value});

  Future<void> updateNodeSetting(UpdateNodeSettingRequest request);

  Future<void> moveNode(MoveNodeRequest request);

  Future<void> deleteNode(String path);

  Future<void> hideNode(String path);

  Future<void> showNode(ShowNodeRequest request);

  Future<void> renameNode(RenameNodeRequest request);

  Future<void> disconnectPorts(String path);

  Future<void> duplicateNode(DuplicateNodeRequest request);

  Future<void> groupNodes(List<String> nodes, {String? parent});

  Future<NodesPointer> getNodesPointer();
}

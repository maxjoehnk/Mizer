import 'package:mizer/api/plugin/ffi/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

abstract class NodesApi {
  Future<Nodes> getNodes();

  Future<List<AvailableNode>> getAvailableNodes();

  Future<Node> addNode(AddNodeRequest request);

  Future<void> linkNodes(NodeConnection connection);
  Future<void> unlinkNodes(NodeConnection connection);

  Future<void> writeControlValue(
      {required String path, required String port, required double value});

  Future<void> updateNodeSetting(UpdateNodeSettingRequest request);
  Future<void> updateNodeColor(UpdateNodeColorRequest request);

  Future<void> moveNodes(MoveNodesRequest request);

  Future<void> deleteNodes(List<String> paths);

  Future<void> hideNode(String path);

  Future<void> showNode(ShowNodeRequest request);

  Future<void> renameNode(RenameNodeRequest request);

  Future<void> disconnectPorts(String path);

  Future<void> disconnectPort(String path, String port);

  Future<List<String>> duplicateNodes(DuplicateNodesRequest request);

  Future<void> groupNodes(List<String> nodes, {String? parent});

  Future<void> addComment(AddCommentRequest request);
  Future<void> updateComment(UpdateCommentRequest request);
  Future<void> deleteComment(String id);

  Future<NodesPointer> getNodesPointer();

  Future<void> openNodesView();
  Future<void> closeNodesView();
}

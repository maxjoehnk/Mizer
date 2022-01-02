import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/models/port_model.dart';

import 'node_model.dart';

class NodeEditorModel extends ChangeNotifier {
  List<Node> hidden = [];
  List<NodeModel> nodes = [];
  List<NodeConnection> channels = [];
  final GlobalKey painterKey = GlobalKey(debugLabel: "GraphPaintLayer");

  late TransformationController transformationController;
  NodeModel? selectedNode;
  NewConnectionModel? connecting;

  NodeEditorModel(Nodes nodes) {
    this.refresh(nodes);
    transformationController = TransformationController()..addListener(update);
  }

  void refresh(Nodes nodes) {
    this._disposeOldNodes();
    this.nodes = nodes.nodes.where((node) => !node.designer.hidden).map((node) {
      var nodeModel = NodeModel(node: node, key: GlobalKey(debugLabel: "Node ${node.path}"));
      nodeModel.addListener(this.update);
      return nodeModel;
    }).toList();
    this.hidden = nodes.nodes.where((node) => node.designer.hidden).toList();
    this.channels = nodes.channels;
    this.updateNodes();
    this.update();
  }

  void updateNodes() {
    for (var node in nodes) {
      node.update(painterKey);
      node.updatePorts(painterKey);
    }
  }

  void update() {
    notifyListeners();
  }

  PortModel? getPortModel(Node node, Port port, bool input) {
    NodeModel? nodeModel = this.nodes.firstWhereOrNull((nodeModel) => nodeModel.node == node);

    if (nodeModel == null) {
      return null;
    }

    return nodeModel.ports.firstWhereOrNull(
        (portModel) => portModel.port.name == port.name && portModel.input == input);
  }

  Node getNode(String path) {
    return nodes.firstWhere((nodeModel) => nodeModel.node.path == path).node;
  }

  selectNode(NodeModel nodeModel) {
    this.selectedNode = nodeModel;
    this.update();
  }

  dragNewConnection(NewConnectionModel model) {
    connecting = model;
    this.updateNewConnection();
  }

  dropNewConnection() {
    connecting = null;
    this.updateNewConnection();
  }

  updateNewConnection() {
    connecting?.update(painterKey);
    this.update();
  }

  void _disposeOldNodes() {
    for (var node in nodes) {
      node.dispose();
    }
  }
}

class NewConnectionModel {
  Port port;
  Node node;
  Offset offset;
  GlobalKey key;

  NewConnectionModel(
      {required this.port, required this.node, this.offset = Offset.zero, required this.key});

  void update(GlobalKey key) {
    if (key.currentContext == null || this.key.currentContext == null) {
      return;
    }
    RenderBox thisBox = this.key.currentContext!.findRenderObject() as RenderBox;
    RenderBox thatBox = key.currentContext!.findRenderObject() as RenderBox;
    this.offset = thatBox.globalToLocal(thisBox.localToGlobal(Offset.zero));
  }
}

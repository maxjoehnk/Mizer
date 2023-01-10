import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/models/port_model.dart';

import 'node_model.dart';

/// State Object for the Nodes view
class NodeEditorModel extends ChangeNotifier {
  List<NodeModel> rootNodes = [];
  List<NodeConnection> _channels = [];
  final GlobalKey painterKey = GlobalKey(debugLabel: "GraphPaintLayer");

  late TransformationController transformationController;
  NodeModel? selectedNode;
  List<NodeModel> otherSelectedNodes = [];
  NewConnectionModel? connecting;

  NodeModel? parent;
  List<NodeModel>? currentNodes;
  List<String> path = [];

  NodeEditorModel(Nodes nodes) {
    this.refresh(nodes);
    transformationController = TransformationController()..addListener(update);
  }

  List<NodeModel> get hidden {
    return this.rootNodes.where((nm) => nm.node.designer.hidden).toList();
  }

  List<NodeModel> get nodes {
    if (parent != null) {
      return currentNodes!;
    }
    return rootNodes;
  }

  List<NodeConnection> get channels {
    return this._channels
        .where((channel) => nodes.any((node) => channel.sourceNode == node.node.path || channel.targetNode == node.node.path))
        .toList();
  }

  /// Rebuild the node and port states
  void refresh(Nodes nodes) {
    this._disposeOldNodes();
    this.rootNodes = nodes.nodes
        .map(this._createModel)
        .map((nodeModel) {
          nodeModel.addListener(this.update);
          return nodeModel;
        })
        .toList();
    this.rootNodes.sortBy((element) => element.node.path);
    this._channels = nodes.channels;
    var parent = this.rootNodes.firstWhereOrNull((element) => element.node.path == this.parent?.node.path);
    if (parent != null) {
      this.parent = parent;
      List<NodeModel> nodeModels = parent.node.config.containerConfig.nodes.map(_createModel).toList();
      this.currentNodes = nodeModels;
    }
    this.updateNodes();
    this.update();
  }
  
  NodeModel _createModel(Node node) {
    var previousNode = this.nodes.firstWhereOrNull((element) => element.node.path == node.path);
    if (previousNode != null) {
      return previousNode.updateNode(node, GlobalKey(debugLabel: "Node ${node.path}"));
    }
    return NodeModel(node: node, key: GlobalKey(debugLabel: "Node ${node.path}"));
  }

  /// Recalculate node position and sizes
  void updateNodes() {
    for (var node in nodes) {
      node.update(painterKey);
      node.updatePorts(painterKey);
    }
  }

  /// Notify listeners of changes
  void update() {
    notifyListeners();
  }

  /// Returns the [PortModel] for the given [node] and [port] combination
  PortModel? getPortModel(Node node, Port port, bool input) {
    NodeModel? nodeModel = this.nodes.firstWhereOrNull((nodeModel) => nodeModel.node == node);

    if (nodeModel == null) {
      return null;
    }

    return nodeModel.ports.firstWhereOrNull(
        (portModel) => portModel.port.name == port.name && portModel.input == input);
  }

  /// Returns the [Node] with the given path
  Node? getNode(String path) {
    return nodes.firstWhereOrNull((nodeModel) => nodeModel.node.path == path)?.node;
  }

  selectNode(NodeModel nodeModel) {
    this.selectedNode = nodeModel;
    this.otherSelectedNodes.clear();
    this.update();
  }

  selectAdditionalNodes(List<NodeModel> nodes) {
    for (var node in nodes) {
      this.otherSelectedNodes.add(node);
    }
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
    var ports = nodes.map((nm) => nm.ports.map((port) => PortTarget(nm.node, port))).flattened;
    connecting?.update(painterKey, ports);
    this.update();
  }

  openContainer(NodeModel nodeModel) {
    List<NodeModel> nodeModels = nodeModel.node.config.containerConfig.nodes.map(_createModel).toList();
    this.currentNodes = nodeModels;
    this.parent = nodeModel;
    this.path = [nodeModel.node.path.substring(1)];
    this.notifyListeners();
  }

  closeContainer() {
    this.path = [];
    this.currentNodes = null;
    this.parent = null;
    this.notifyListeners();
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
  PortTarget? target;

  NewConnectionModel(
      {required this.port, required this.node, this.offset = Offset.zero, required this.key});

  void update(GlobalKey key, Iterable<PortTarget> allPorts) {
    if (key.currentContext == null || this.key.currentContext == null) {
      return;
    }
    RenderBox thisBox = this.key.currentContext!.findRenderObject() as RenderBox;
    RenderBox targetBox = key.currentContext!.findRenderObject() as RenderBox;
    this.offset = targetBox.globalToLocal(thisBox.localToGlobal(Offset.zero));
    double BUBBLE_DISTANCE = 32;
    var connectionBubble = Rect.fromCenter(center: this.offset, width: BUBBLE_DISTANCE, height: BUBBLE_DISTANCE);
    this.target = allPorts
        .where((target) => target.port.port.protocol == port.protocol)
        .firstWhereOrNull((target) => connectionBubble.contains(target.port.offset));
    if (target != null) {
      this.offset = target!.port.offset;
    }
  }
}

class PortTarget {
  final Node node;
  final PortModel port;
  
  PortTarget(this.node, this.port);
}

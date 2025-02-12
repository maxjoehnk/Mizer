import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/port_model.dart';

import 'node_model.dart';

/// State Object for the Nodes view
class NodeEditorModel extends ChangeNotifier {
  List<NodeModel> rootNodes = [];
  List<NodeConnection> _channels = [];
  List<NodeCommentArea> _comments = [];
  final GlobalKey painterKey = GlobalKey(debugLabel: "GraphPaintLayer");

  late TransformationController transformationController;
  NodeModel? selectedNode;
  List<NodeModel> otherSelectedNodes = [];
  List<NodeModel> connectedToSelectedNodes = [];
  NewConnectionModel? connecting;

  NodeCommentArea? selectedComment;

  NodeModel? parent;
  List<NodeModel>? currentNodes;
  List<String> path = [];

  NodeEditorModel(PipelineState nodes) {
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
  
  Iterable<NodeCommentArea> get comments {
    if (parent != null) {
      return this._comments.where((c) => c.parent == parent!.node.path);
    }
    return this._comments.where((c) => !c.hasParent());
  }

  List<NodeConnection> get channels {
    return this
        ._channels
        .where((channel) => nodes.any(
            (node) => channel.sourceNode == node.node.path || channel.targetNode == node.node.path))
        .toList();
  }

  List<NodeModel> get selection {
    if (selectedNode == null) {
      return otherSelectedNodes;
    }
    return [selectedNode!, ...otherSelectedNodes];
  }

  /// Rebuild the node and port states
  void refresh(PipelineState nodes) {
    this._disposeOldNodes();
    this.rootNodes = nodes.nodes.map(this._createModel).map((nodeModel) {
      nodeModel.addListener(this.update);
      return nodeModel;
    }).toList();
    this.rootNodes.sortBy((element) => element.node.path);
    this._channels = nodes.channels;
    this._comments = nodes.comments;
    var parent =
        this.rootNodes.firstWhereOrNull((element) => element.node.path == this.parent?.node.path);
    if (parent != null) {
      this.parent = parent;
      List<NodeModel> nodeModels = parent.node.children.map(_createModel).toList();
      this.currentNodes = nodeModels;
    }
    this.updateNodes();
    this.update();
    if (nodes.selectedNodes.isNotEmpty) {
      this.selectedNode = null;
      this.otherSelectedNodes = nodes.selectedNodes
          .map((path) => this.nodes.firstWhereOrNull((element) => element.node.path == path))
          .whereNotNull()
          .toList();
    }else {
      this.selectedNode =
          this.nodes.firstWhereOrNull((element) => element.node.path == this.selectedNode?.node.path);
      this.otherSelectedNodes = this.otherSelectedNodes
          .map((node) => this.nodes.firstWhereOrNull((element) => element.node.path == node.node.path))
          .whereNotNull()
          .toList();
    }
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

  /// Recalculate port positions so the graph connections re-render
  void updateMovement() {
    nodes.where((node) => isSelected(node.node.path)).forEach((element) {
      element.updatePorts(painterKey);
    });
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

  List<Node> getContainerNodes(NodeModel container) {
    return container.node.children;
  }

  List<NodeConnection> getContainerConnections(NodeModel container) {
    var containerNodes = getContainerNodes(container);

    return this._channels.where((channel) => containerNodes.any((n) => n.path == channel.sourceNode || n.path == channel.targetNode))
        .toList();
  }

  /// Returns the [Node] with the given path
  Node? getNode(String path) {
    return nodes.firstWhereOrNull((nodeModel) => nodeModel.node.path == path)?.node;
  }

  bool isSelected(String nodePath) {
    return this.selectedNode?.node.path == nodePath || this.otherSelectedNodes.any((element) => element.node.path == nodePath);
  }

  selectNode(NodeModel nodeModel) {
    this.selectedComment = null;
    this.selectedNode = nodeModel;
    this.otherSelectedNodes.clear();
    this.connectedToSelectedNodes = this
        .channels
        .where((channel) =>
            channel.sourceNode == nodeModel.node.path || channel.targetNode == nodeModel.node.path)
        .map((channel) {
      var path =
          channel.sourceNode == nodeModel.node.path ? channel.targetNode : channel.sourceNode;

      return this.nodes.firstWhere((n) => n.node.path == path);
    }).toList();

    this.update();
  }
  
  selectNodes(List<NodeModel> nodes) {
    this.selectedNode = null;
    this.selectedComment = null;
    this.otherSelectedNodes = nodes;
    this.update();
  }

  selectAdditionalNode(NodeModel node) {
    this.otherSelectedNodes.add(node);
    this.update();
  }

  selectComment(NodeCommentArea comment) {
    this.selectedNode = null;
    this.selectedComment = comment;
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
    List<NodeModel> nodeModels = nodeModel.node.children.map(_createModel).toList();
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
    var connectionBubble =
        Rect.fromCenter(center: this.offset, width: BUBBLE_DISTANCE, height: BUBBLE_DISTANCE);
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

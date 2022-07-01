import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/nodes/models/port_model.dart';

enum NodeTab {
  Ports,
  Preview,
  ContainerEditor,
}

class NodeModel extends ChangeNotifier {
  final Node node;
  final GlobalKey key;
  final List<PortModel> ports = [];
  NodeTab tab = NodeTab.Ports;
  Offset offset = Offset.infinite;
  Size size = Size.zero;

  NodeModel({required this.key, required this.node}) {
    _applyOffset(node);
    _buildPorts();
    if (node.type == Node_NodeType.Container) {
      this.tab = NodeTab.ContainerEditor;
    }
  }

  NodeModel updateNode(Node node, GlobalKey key) {
    var next = NodeModel(key: key, node: node);
    next.tab = this.tab;
    next.offset = this.offset;
    next.size = this.size;

    return next;
  }

  void update(GlobalKey key) {
    if (key.currentContext == null || this.key.currentContext == null) {
      return;
    }
    RenderBox thisBox = this.key.currentContext!.findRenderObject() as RenderBox;
    RenderBox thatBox = key.currentContext!.findRenderObject() as RenderBox;
    this.offset = thatBox.globalToLocal(thisBox.localToGlobal(Offset.zero));
    size = thisBox.size;
  }

  void updatePorts(GlobalKey key) {
    for (var port in ports) {
      port.update(key);
    }
  }

  void selectTab(NodeTab tab) {
    this.tab = tab;
    this.notifyListeners();
  }

  void _applyOffset(Node node) {
    offset = Offset(node.designer.position.x * MULTIPLIER, node.designer.position.y * MULTIPLIER);
  }

  void _buildPorts() {
    for (var input in node.inputs) {
      ports.add(PortModel(
          key: GlobalKey(debugLabel: "Node: ${node.path}, Input: ${input.name}"),
          port: input,
          input: true));
    }
    for (var output in node.outputs) {
      ports.add(PortModel(
          key: GlobalKey(debugLabel: "Node: ${node.path}, Output: ${output.name}"),
          port: output,
          input: false));
    }
  }

  Offset getPosition() {
    return Offset(offset.dx / MULTIPLIER, offset.dy / MULTIPLIER);
  }
}

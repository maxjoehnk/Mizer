import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/nodes/models/port_model.dart';

class NodeModel {
  final Node node;
  final GlobalKey key;
  final List<PortModel> ports;
  Offset offset = Offset.infinite;
  Size size = Size.zero;

  NodeModel({required this.key, required this.node}) : this.ports = [] {
    _applyOffset(node);
    _buildPorts();
  }

  void update(GlobalKey key) {
    if (key.currentContext == null || this.key.currentContext == null) return;
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

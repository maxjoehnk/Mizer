import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'consts.dart';
import 'node/base_node.dart';

class NodeCanvas extends StatefulWidget {
  final Nodes nodes;

  NodeCanvas({this.nodes});

  @override
  _NodeCanvasState createState() => _NodeCanvasState();
}

class _NodeCanvasState extends State<NodeCanvas> {
  Node selectedNode;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
        delegate: NodesLayoutDelegate(this.widget.nodes),
        children: this
            .widget
            .nodes
            .nodes
            .map((node) => LayoutId(
                id: node.path,
                child: BaseNode.fromNode(
                  node,
                  onSelect: () => setState(() => selectedNode = node),
                  selected: node == selectedNode,
                )))
            .toList());
  }
}

class NodesLayoutDelegate extends MultiChildLayoutDelegate {
  final Nodes nodes;

  NodesLayoutDelegate(this.nodes);

  @override
  void performLayout(Size size) {
    for (var node in this.nodes.nodes) {
      layoutChild(node.path, BoxConstraints.loose(size));
      var offset = Offset(node.designer.position.x * MULTIPLIER + (CANVAS_SIZE / 2),
          node.designer.position.y * MULTIPLIER + (CANVAS_SIZE / 2));
      positionChild(node.path, offset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

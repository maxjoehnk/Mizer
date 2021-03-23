import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'consts.dart';
import 'node/base_node.dart';

class NodeCanvas extends StatelessWidget {
  final List<Node> selectedNodes;
  final Nodes nodes;
  final Function(Node) onSelect;

  NodeCanvas({this.nodes, this.selectedNodes, this.onSelect });

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
        delegate: NodesLayoutDelegate(this.nodes),
        children: this
            .nodes
            .nodes
            .map((node) => LayoutId(
            id: node.path,
            child: BaseNode.fromNode(
              node,
              onSelect: () => this.onSelect(node),
              selected: this.selectedNodes.contains(node),
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

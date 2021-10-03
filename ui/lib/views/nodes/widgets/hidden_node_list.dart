import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/node/base_node.dart';

class HiddenNodeList extends StatelessWidget {
  final List<Node> nodes;

  const HiddenNodeList({this.nodes, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      // TODO: allow moving out of hidden list
      child: ListView(children: nodes.map((node) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BaseNode.fromNode(node),
      )).toList()),
    );
  }
}

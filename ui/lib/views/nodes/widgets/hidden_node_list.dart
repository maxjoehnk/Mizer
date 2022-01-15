import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/node_control.dart';

class HiddenNodeList extends StatelessWidget {
  final List<NodeModel> nodes;

  const HiddenNodeList({required this.nodes, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      // TODO: allow moving out of hidden list
      child: ListView(children: nodes.map((node) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: NodeControl(node),
      )).toList()),
    );
  }
}

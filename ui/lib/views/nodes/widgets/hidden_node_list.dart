import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/node_control.dart';
import 'package:mizer/widgets/panel.dart';

class HiddenNodeList extends StatelessWidget {
  final List<NodeModel> nodes;

  const HiddenNodeList({required this.nodes, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Hidden Nodes",
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListView(
            children: nodes
                .map((node) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: NodeControl(node, collapsed: true),
                    ))
                .toList()),
      ),
    );
  }
}

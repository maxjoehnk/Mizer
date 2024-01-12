import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/node_control.dart';

class HiddenNodeList extends StatelessWidget {
  final List<NodeModel> nodes;
  final String? search;

  const HiddenNodeList({required this.nodes, Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListView(
          children: nodes
              .search([(n) => n.node.path], search)
              .map((node) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: NodeControl(node, collapsed: true),
                  ))
              .toList()),
    );
  }
}

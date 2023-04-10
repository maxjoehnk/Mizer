import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/node_control.dart';
import 'package:mizer/widgets/panel.dart';

class HiddenNodeList extends StatefulWidget {
  final List<NodeModel> nodes;

  const HiddenNodeList({required this.nodes, Key? key}) : super(key: key);

  @override
  State<HiddenNodeList> createState() => _HiddenNodeListState();
}

class _HiddenNodeListState extends State<HiddenNodeList> {
  String? search;

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Hidden Nodes",
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListView(
            children: widget.nodes
                .search([(n) => n.node.path], search)
                .map((node) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: NodeControl(node, collapsed: true),
                    ))
                .toList()),
      ),
      onSearch: (query) => setState(() => this.search = query),
    );
  }
}

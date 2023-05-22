import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/text_field.dart';
import 'property_group.dart';

class NodeProperties extends StatelessWidget {
  final Node node;

  const NodeProperties({required this.node, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Node", children: [
      TextPropertyField(
        label: "Path",
        value: node.path,
        onUpdate: (String path) {},
      )
    ]);
  }
}

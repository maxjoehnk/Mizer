import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/enum_field.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/text_field.dart';
import 'property_group.dart';

class NodeProperties extends StatelessWidget {
  final Node node;
  final Function(NodeColor) onUpdateColor;

  const NodeProperties({required this.node, required this.onUpdateColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Node", children: [
      TextPropertyField(
        label: "Path",
        readOnly: true,
        value: node.path,
        onUpdate: (String path) {},
      ),
      TextPropertyField(
        label: "Name",
        readOnly: true,
        value: node.details.hasCustomName ? node.details.displayName : "",
        placeholder: node.details.displayName,
        onUpdate: (String path) {},
      ),
      TextPropertyField(
        label: "Type",
        readOnly: true,
        value: "",
        placeholder: node.details.nodeTypeName,
        onUpdate: (String path) {},
      ),
      EnumField<NodeColor>(
          label: "Color",
          initialValue: node.designer.color,
          items: NodeColor.values
              .map((color) => SelectOption(
                  label: color.name.replaceAll("NODE_COLOR_", "").toSentenceCase(), value: color))
              .toList(),
          onUpdate: onUpdateColor)
    ]);
  }
}

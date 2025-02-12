import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/boolean_field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/text_field.dart';
import 'package:mizer/views/nodes/widgets/properties/groups/property_group.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';

class NodeCommentAreaProperties extends StatelessWidget {
  final NodeCommentArea comment;

  final Function(UpdateCommentRequest) onUpdate;

  const NodeCommentAreaProperties({super.key, required this.comment, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Comment", children: [
      EnumField<NodeColor>(
          label: "Color",
          initialValue: comment.designer.color,
          items: NodeColor.values
              .where((element) => element != NodeColor.NODE_COLOR_NONE)
              .map((color) => SelectOption(
                  label: color.name.replaceAll("NODE_COLOR_", "").toSentenceCase(), value: color))
              .toList(),
          onUpdate: (color) => onUpdate(UpdateCommentRequest(id: comment.id, color: color))),
      TextPropertyField(
        label: "Text",
        value: comment.label,
        multiline: true,
        onUpdate: (text) => onUpdate(UpdateCommentRequest(id: comment.id, label: text)),
      ),
      BooleanField(
          label: "Background",
          value: comment.showBackground,
          onUpdate: (showBackground) =>
              onUpdate(UpdateCommentRequest(id: comment.id, showBackground: showBackground))),
      BooleanField(
          label: "Border",
          value: comment.showBorder,
          onUpdate: (showBorder) =>
              onUpdate(UpdateCommentRequest(id: comment.id, showBorder: showBorder))),
    ]);
  }
}

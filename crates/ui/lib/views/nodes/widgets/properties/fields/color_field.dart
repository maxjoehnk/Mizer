import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/field/field.dart';

class ColorField extends StatelessWidget {
  final String label;
  final double? labelWidth;
  final NodeSetting_ColorValue value;
  final bool vertical;
  final Function(NodeSetting_ColorValue) onUpdate;

  ColorField({required this.label, this.labelWidth, required this.value, this.vertical = false, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Field(
        label: label,
        labelWidth: labelWidth,
        vertical: vertical,
        child: Container(
          height: INPUT_FIELD_HEIGHT,
          alignment: vertical ? Alignment.center : Alignment.centerRight,
          padding: const EdgeInsets.all(2),
          child: Container(decoration: BoxDecoration(
            color: value.asFlutterColor,
            borderRadius: BorderRadius.circular(2),
          )),
        ));
  }
}

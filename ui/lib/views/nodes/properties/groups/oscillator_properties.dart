import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/properties/enum_field.dart';
import 'package:mizer/views/nodes/properties/number_field.dart';

import '../property_group.dart';

class OscillatorProperties extends StatelessWidget {
  final OscillatorNodeConfig config;

  OscillatorProperties(this.config);

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Oscillator", children: [
      EnumField(
          label: "Type",
          initialValue: config.type.value.toString(),
          items: OscillatorNodeConfig_OscillatorType.values
              .map((e) => EnumItem(value: e.value.toString(), label: e.name))
              .toList()),
      NumberField(
        label: "Min",
        value: this.config.min,
      ),
      NumberField(
        label: "Max",
        value: this.config.max,
      ),
      NumberField(
        label: "Ratio",
        value: this.config.ratio,
      ),
      NumberField(
        label: "Offset",
        value: this.config.offset,
      ),
    ]);
  }
}

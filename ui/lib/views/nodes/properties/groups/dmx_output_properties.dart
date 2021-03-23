import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/properties/number_field.dart';
import 'package:mizer/views/nodes/properties/property_group.dart';

class DmxOutputProperties extends StatelessWidget {
  final DmxOutputNodeConfig config;

  DmxOutputProperties(this.config);

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Dmx Output", children: [
      // EnumField(label: "Output", ),
      NumberField(label: "Universe", value: this.config.universe, min: 1, max: 32768, fractions: false,),
      NumberField(label: "Channel", value: this.config.channel, min: 1, max: 512, fractions: false,),
    ]);
  }
}

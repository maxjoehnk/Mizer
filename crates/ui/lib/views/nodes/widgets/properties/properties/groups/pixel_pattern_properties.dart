import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class PixelPatternProperties extends StatefulWidget {
  final PixelPatternNodeConfig config;
  final Function(PixelPatternNodeConfig) onUpdate;

  PixelPatternProperties(this.config, {required this.onUpdate});

  @override
  _PixelPatternPropertiesState createState() => _PixelPatternPropertiesState(config);
}

class _PixelPatternPropertiesState extends State<PixelPatternProperties> {
  PixelPatternNodeConfig state;

  _PixelPatternPropertiesState(this.state);

  @override
  void didUpdateWidget(PixelPatternProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Pixel Pattern", children: [
      EnumField(
          label: "Pattern",
          initialValue: widget.config.pattern.value,
          items: PixelPatternNodeConfig_Pattern.values
              .map((e) => SelectOption(value: e.value, label: e.name.toCapitalCase()))
              .toList(),
          onUpdate: _updatePattern),
    ]);
  }

  void _updatePattern(int type) {
    log("_updatePattern $type", name: "OscillatorProperties");
    setState(() {
      state.pattern = PixelPatternNodeConfig_Pattern.valueOf(type)!;
      widget.onUpdate(state);
    });
  }
}

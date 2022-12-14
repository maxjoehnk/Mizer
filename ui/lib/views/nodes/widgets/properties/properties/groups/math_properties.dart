import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class MathProperties extends StatefulWidget {
  final MathNodeConfig config;
  final Function(MathNodeConfig) onUpdate;

  MathProperties(this.config, {required this.onUpdate});

  @override
  _MathPropertiesState createState() => _MathPropertiesState(config);
}

class _MathPropertiesState extends State<MathProperties> {
  MathNodeConfig state;

  _MathPropertiesState(this.state);

  @override
  void didUpdateWidget(MathProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Math", children: [
      EnumField(
          label: "Mode",
          initialValue: widget.config.mode.value,
          items: MathNodeConfig_Mode.values
              .map((e) => SelectOption(value: e.value, label: e.name))
              .toList(),
          onUpdate: _updateMode),
    ]);
  }

  void _updateMode(int mode) {
    log("_updateMode $mode", name: "MathProperties");
    setState(() {
      state.mode = MathNodeConfig_Mode.valueOf(mode)!;
      widget.onUpdate(state);
    });
  }
}

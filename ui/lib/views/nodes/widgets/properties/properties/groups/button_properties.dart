import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/checkbox_field.dart';
import '../property_group.dart';

class ButtonProperties extends StatefulWidget {
  final ButtonNodeConfig config;
  final Function(ButtonNodeConfig) onUpdate;

  ButtonProperties(this.config, {required this.onUpdate});

  @override
  _ButtonPropertiesState createState() => _ButtonPropertiesState(config);
}

class _ButtonPropertiesState extends State<ButtonProperties> {
  ButtonNodeConfig state;

  _ButtonPropertiesState(this.state);

  @override
  void didUpdateWidget(ButtonProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Button", children: [
      CheckboxField(
        label: "Toggle",
        value: widget.config.toggle,
        onUpdate: _updateToggle,
      )
    ]);
  }

  void _updateToggle(bool toggle) {
    log("_updateToggle $toggle", name: "ButtonProperties");
    setState(() {
      state.toggle = toggle;
      widget.onUpdate(state);
    });
  }
}

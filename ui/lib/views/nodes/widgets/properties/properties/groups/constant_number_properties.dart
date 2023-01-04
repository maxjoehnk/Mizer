import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/number_field.dart';
import '../property_group.dart';

class ConstantNumberProperties extends StatefulWidget {
  final ConstantNumberNodeConfig config;
  final Function(ConstantNumberNodeConfig) onUpdate;

  ConstantNumberProperties(this.config, {required this.onUpdate});

  @override
  _ConstantNumberPropertiesState createState() => _ConstantNumberPropertiesState(config);
}

class _ConstantNumberPropertiesState extends State<ConstantNumberProperties> {
  ConstantNumberNodeConfig state;

  _ConstantNumberPropertiesState(this.state);

  @override
  void didUpdateWidget(ConstantNumberProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "ConstantNumber", children: [
      NumberField(
        label: "Value",
        value: this.widget.config.value,
        minHint: 0,
        maxHint: 1,
        onUpdate: _updateValue,
        fractions: true,
      ),
    ]);
  }

  void _updateValue(num value) {
    log("_updateValue $value", name: "ConstantNumberProperties");
    setState(() {
      state.value = value.toDouble();
      widget.onUpdate(state);
    });
  }
}

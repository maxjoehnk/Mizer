import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../property_group.dart';
import '../text_field.dart';

class ValueProperties extends StatefulWidget {
  final ValueNodeConfig config;
  final Function(ValueNodeConfig) onUpdate;

  ValueProperties(this.config, {required this.onUpdate});

  @override
  _ValuePropertiesState createState() => _ValuePropertiesState(config);
}

class _ValuePropertiesState extends State<ValueProperties> {
  ValueNodeConfig state;

  _ValuePropertiesState(this.state);

  @override
  void didUpdateWidget(ValueProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Value", children: [
      TextPropertyField(
        label: "Value",
        value: this.widget.config.value,
        onUpdate: _updateValue,
        multiline: true,
      ),
    ]);
  }

  void _updateValue(String value) {
    log("_updateValue $value", name: "ValueProperties");
    setState(() {
      state.value = value;
      widget.onUpdate(state);
    });
  }
}

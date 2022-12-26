import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../property_group.dart';
import '../fields/text_field.dart';

class LabelProperties extends StatefulWidget {
  final LabelNodeConfig config;
  final Function(LabelNodeConfig) onUpdate;

  LabelProperties(this.config, {required this.onUpdate});

  @override
  _LabelPropertiesState createState() => _LabelPropertiesState(config);
}

class _LabelPropertiesState extends State<LabelProperties> {
  LabelNodeConfig state;

  _LabelPropertiesState(this.state);

  @override
  void didUpdateWidget(LabelProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Label", children: [
      TextPropertyField(
        label: "Text",
        value: this.widget.config.text,
        onUpdate: _updateText,
      ),
    ]);
  }

  void _updateText(String value) {
    log("_updateText $value", name: "LabelProperties");
    setState(() {
      state.text = value;
      widget.onUpdate(state);
    });
  }
}

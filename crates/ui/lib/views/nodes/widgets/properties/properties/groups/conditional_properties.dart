import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../fields/number_field.dart';
import '../property_group.dart';

class ConditionalProperties extends StatefulWidget {
  final ConditionalNodeConfig config;
  final Function(ConditionalNodeConfig) onUpdate;

  ConditionalProperties(this.config, {required this.onUpdate});

  @override
  _ConditionalPropertiesState createState() => _ConditionalPropertiesState(config);
}

class _ConditionalPropertiesState extends State<ConditionalProperties> {
  ConditionalNodeConfig state;

  _ConditionalPropertiesState(this.state);

  @override
  void didUpdateWidget(ConditionalProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Conditional", children: [
      NumberField(
        label: "Threshold",
        value: this.widget.config.threshold,
        minHint: 0,
        maxHint: 1,
        onUpdate: _updateThreshold,
        fractions: true,
      ),
    ]);
  }

  void _updateThreshold(num threshold) {
    log("_updateThreshold $threshold", name: "ConditionalProperties");
    setState(() {
      state.threshold = threshold.toDouble();
      widget.onUpdate(state);
    });
  }
}

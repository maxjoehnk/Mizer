import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../number_field.dart';
import '../property_group.dart';

class ThresholdProperties extends StatefulWidget {
  final ThresholdNodeConfig config;
  final Function(ThresholdNodeConfig) onUpdate;

  ThresholdProperties(this.config, {required this.onUpdate});

  @override
  _ThresholdPropertiesState createState() => _ThresholdPropertiesState(config);
}

class _ThresholdPropertiesState extends State<ThresholdProperties> {
  ThresholdNodeConfig state;

  _ThresholdPropertiesState(this.state);

  @override
  void didUpdateWidget(ThresholdProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Threshold", children: [
      NumberField(
        label: "Threshold",
        value: this.widget.config.threshold,
        onUpdate: _updateThreshold,
        fractions: true,
      ),
      NumberField(
        label: "Inactive Value",
        value: this.widget.config.inactiveValue,
        onUpdate: _updateInactive,
        fractions: true,
      ),
      NumberField(
        label: "Active value",
        value: this.widget.config.activeValue,
        onUpdate: _updateActive,
        fractions: true,
      ),
    ]);
  }

  void _updateThreshold(num threshold) {
    log("_updateThreshold $threshold", name: "ThresholdProperties");
    setState(() {
      state.threshold = threshold.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateActive(num active) {
    log("_updateActive $active", name: "ThresholdProperties");
    setState(() {
      state.activeValue = active.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateInactive(num inactive) {
    log("_updateInactive $inactive", name: "ThresholdProperties");
    setState(() {
      state.inactiveValue = inactive.toDouble();
      widget.onUpdate(state);
    });
  }

}

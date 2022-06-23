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
        label: "Lower Threshold",
        value: this.widget.config.lowerThreshold,
        onUpdate: _updateLowerThreshold,
        fractions: true,
      ),
      NumberField(
        label: "Upper Threshold",
        value: this.widget.config.upperThreshold,
        onUpdate: _updateUpperThreshold,
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

  void _updateLowerThreshold(num threshold) {
    log("_updateLowerThreshold $threshold", name: "ThresholdProperties");
    setState(() {
      state.lowerThreshold = threshold.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateUpperThreshold(num threshold) {
    log("_updateUpperThreshold $threshold", name: "ThresholdProperties");
    setState(() {
      state.upperThreshold = threshold.toDouble();
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

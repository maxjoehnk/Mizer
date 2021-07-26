import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../enum_field.dart';
import '../number_field.dart';
import '../property_group.dart';

class OscillatorProperties extends StatefulWidget {
  final OscillatorNodeConfig config;
  final Function(OscillatorNodeConfig) onUpdate;

  OscillatorProperties(this.config, {@required this.onUpdate});

  @override
  _OscillatorPropertiesState createState() => _OscillatorPropertiesState(config);
}

class _OscillatorPropertiesState extends State<OscillatorProperties> {
  OscillatorNodeConfig state;

  _OscillatorPropertiesState(this.state);

  @override
  void didUpdateWidget(OscillatorProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Oscillator", children: [
      EnumField(
          label: "Type",
          initialValue: widget.config.type.value,
          items: OscillatorNodeConfig_OscillatorType.values
              .map((e) => SelectOption(value: e.value, label: e.name))
              .toList(),
          onUpdate: _updateType),
      NumberField(
        label: "Min",
        value: this.widget.config.min,
        onUpdate: _updateMin,
        fractions: true,
      ),
      NumberField(
        label: "Max",
        value: this.widget.config.max,
        onUpdate: _updateMax,
        fractions: true,
      ),
      NumberField(
        label: "Ratio",
        value: this.widget.config.ratio,
        onUpdate: _updateRatio,
        fractions: true,
      ),
      NumberField(
        label: "Offset",
        value: this.widget.config.offset,
        onUpdate: _updateOffset,
        fractions: true,
      ),
    ]);
  }

  void _updateType(int type) {
    log("_updateType $type", name: "OscillatorProperties");
    setState(() {
      state.type = OscillatorNodeConfig_OscillatorType.valueOf(type);
      widget.onUpdate(state);
    });
  }

  void _updateMin(num min) {
    log("_updateMin $min", name: "OscillatorProperties");
    setState(() {
      state.min = min.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateMax(num max) {
    log("_updateMax $max", name: "OscillatorProperties");
    setState(() {
      state.max = max.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateRatio(num ratio) {
    log("_updateRatio $ratio", name: "OscillatorProperties");
    setState(() {
      state.ratio = ratio.toDouble();
      widget.onUpdate(state);
    });
  }

  void _updateOffset(num offset) {
    log("_updateOffset $offset", name: "OscillatorProperties");
    setState(() {
      state.offset = offset.toDouble();
      widget.onUpdate(state);
    });
  }
}

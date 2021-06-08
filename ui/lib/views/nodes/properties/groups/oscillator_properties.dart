import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/properties/enum_field.dart';
import 'package:mizer/views/nodes/properties/number_field.dart';

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
              .map((e) => EnumItem(value: e.value, label: e.name))
              .toList(),
          onUpdate: _updateType),
      NumberField(
        label: "Min",
        value: this.widget.config.min,
        onUpdate: _updateMin,
      ),
      NumberField(
        label: "Max",
        value: this.widget.config.max,
        onUpdate: _updateMax,
      ),
      NumberField(
        label: "Ratio",
        value: this.widget.config.ratio,
        onUpdate: _updateRatio,
      ),
      NumberField(
        label: "Offset",
        value: this.widget.config.offset,
        onUpdate: _updateOffset,
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
      state.min = min;
      widget.onUpdate(state);
    });
  }

  void _updateMax(num max) {
    log("_updateMax $max", name: "OscillatorProperties");
    setState(() {
      state.max = max;
      widget.onUpdate(state);
    });
  }

  void _updateRatio(num ratio) {
    log("_updateRatio $ratio", name: "OscillatorProperties");
    setState(() {
      state.ratio = ratio;
      widget.onUpdate(state);
    });
  }

  void _updateOffset(num offset) {
    log("_updateOffset $offset", name: "OscillatorProperties");
    setState(() {
      state.offset = offset;
      widget.onUpdate(state);
    });
  }
}

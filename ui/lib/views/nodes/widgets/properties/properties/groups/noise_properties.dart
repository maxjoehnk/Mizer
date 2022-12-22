import 'dart:developer';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/fields/checkbox_field.dart';

import '../fields/number_field.dart';
import '../property_group.dart';

class NoiseProperties extends StatefulWidget {
  final NoiseNodeConfig config;
  final Function(NoiseNodeConfig) onUpdate;

  NoiseProperties(this.config, {required this.onUpdate});

  @override
  _NoisePropertiesState createState() => _NoisePropertiesState(config);
}

class _NoisePropertiesState extends State<NoiseProperties> {
  NoiseNodeConfig state;

  _NoisePropertiesState(this.state);

  @override
  void didUpdateWidget(NoiseProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Noise", children: [
      NumberField(
        label: "Tick Rate",
        value: this.widget.config.tickRate.toInt(),
        onUpdate: _updateTickRate,
        fractions: false,
        min: 1,
        maxHint: 300,
      ),
      CheckboxField(
        label: "Fade",
        value: this.widget.config.fade,
        onUpdate: _updateFade,
      ),
    ]);
  }

  void _updateTickRate(num tickRate) {
    log("_updateTickRate $tickRate", name: "NoiseProperties");
    setState(() {
      state.tickRate = Int64(tickRate.toInt());
      widget.onUpdate(state);
    });
  }

  void _updateFade(bool fade) {
    log("_updateFade $fade", name: "NoiseProperties");
    setState(() {
      state.fade = fade;
      widget.onUpdate(state);
    });
  }
}

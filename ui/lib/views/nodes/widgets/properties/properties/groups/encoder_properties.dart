import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../number_field.dart';
import '../property_group.dart';

class EncoderProperties extends StatefulWidget {
  final EncoderNodeConfig config;
  final Function(EncoderNodeConfig) onUpdate;

  EncoderProperties(this.config, {required this.onUpdate});

  @override
  _EncoderPropertiesState createState() => _EncoderPropertiesState(config);
}

class _EncoderPropertiesState extends State<EncoderProperties> {
  EncoderNodeConfig state;

  _EncoderPropertiesState(this.state);

  @override
  void didUpdateWidget(EncoderProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Encoder", children: [
      NumberField(
        label: "Hold Rate",
        value: this.widget.config.holdRate,
        onUpdate: _updateHoldRate,
        min: 0,
        max: 1,
        step: 0.01,
        fractions: true,
      ),
    ]);
  }

  void _updateHoldRate(num rate) {
    log("_updateHoldRate $rate", name: "EncoderProperties");
    setState(() {
      state.holdRate = rate.toDouble();
      widget.onUpdate(state);
    });
  }
}

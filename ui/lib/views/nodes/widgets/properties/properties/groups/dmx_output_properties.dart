// @dart=2.11
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../number_field.dart';
import '../property_group.dart';

class DmxOutputProperties extends StatefulWidget {
  final DmxOutputNodeConfig config;
  final Function(DmxOutputNodeConfig) onUpdate;

  DmxOutputProperties(this.config, {@required this.onUpdate});

  @override
  _DmxOutputPropertiesState createState() => _DmxOutputPropertiesState(config);
}

class _DmxOutputPropertiesState extends State<DmxOutputProperties> {
  DmxOutputNodeConfig state;

  _DmxOutputPropertiesState(this.state);

  @override
  void didUpdateWidget(DmxOutputProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Dmx Output", children: [
      // EnumField(label: "Output", ),
      NumberField(
          label: "Universe",
          value: state.universe,
          min: 1,
          max: 32768,
          fractions: false,
          onUpdate: _updateUniverse),
      NumberField(
          label: "Channel",
          value: state.channel,
          min: 1,
          max: 512,
          fractions: false,
          onUpdate: _updateChannel),
    ]);
  }
  
  void _updateUniverse(num universe) {
    log("_updateUniverse $universe", name: "DmxOutputProperties");
    setState(() {
      state.universe = universe;
      widget.onUpdate(state);
    });
  }

  void _updateChannel(num channel) {
    log("_updateChannel $channel", name: "DmxOutputProperties");
    setState(() {
      state.channel = channel;
      widget.onUpdate(state);
    });
  }
}

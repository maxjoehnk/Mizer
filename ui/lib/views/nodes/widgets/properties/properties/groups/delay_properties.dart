import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../number_field.dart';
import '../property_group.dart';

class DelayProperties extends StatefulWidget {
  final DelayNodeConfig config;
  final Function(DelayNodeConfig) onUpdate;

  DelayProperties(this.config, {required this.onUpdate});

  @override
  _DelayPropertiesState createState() => _DelayPropertiesState(config);
}

class _DelayPropertiesState extends State<DelayProperties> {
  DelayNodeConfig state;

  _DelayPropertiesState(this.state);

  @override
  void didUpdateWidget(DelayProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Delay", children: [
      NumberField(
        label: "BufferSize",
        value: this.widget.config.bufferSize,
        onUpdate: _updateBufferSize,
        fractions: false,
      ),
    ]);
  }

  void _updateBufferSize(num bufferSize) {
    log("_updateBufferSize $bufferSize", name: "DelayProperties");
    setState(() {
      state.bufferSize = bufferSize.toInt();
      widget.onUpdate(state);
    });
  }
}

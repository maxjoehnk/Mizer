import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class MergeProperties extends StatefulWidget {
  final MergeNodeConfig config;
  final Function(MergeNodeConfig) onUpdate;

  MergeProperties(this.config, {required this.onUpdate});

  @override
  _MergePropertiesState createState() => _MergePropertiesState(config);
}

class _MergePropertiesState extends State<MergeProperties> {
  MergeNodeConfig state;

  _MergePropertiesState(this.state);

  @override
  void didUpdateWidget(MergeProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Merge", children: [
      EnumField(
          label: "Mode",
          initialValue: widget.config.mode.value,
          items: MergeNodeConfig_MergeMode.values
              .map((e) => SelectOption(value: e.value, label: e.name))
              .toList(),
          onUpdate: _updateMode),
    ]);
  }

  void _updateMode(int type) {
    log("_updateType $type", name: "OscillatorProperties");
    setState(() {
      state.mode = MergeNodeConfig_MergeMode.valueOf(type)!;
      widget.onUpdate(state);
    });
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/enum_field.dart';
import 'package:mizer/widgets/controls/select.dart';

import '../number_field.dart';
import '../property_group.dart';
import '../text_field.dart';

class OscProperties extends StatefulWidget {
  final OscNodeConfig config;
  final Function(OscNodeConfig) onUpdate;

  OscProperties(this.config, {required this.onUpdate});

  @override
  _OscPropertiesState createState() => _OscPropertiesState(config);
}

class _OscPropertiesState extends State<OscProperties> {
  OscNodeConfig state;

  _OscPropertiesState(this.state);

  @override
  void didUpdateWidget(OscProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "OSC", children: [
      TextPropertyField(
        label: "Host",
        value: this.widget.config.host,
        onUpdate: _updateHost,
      ),
      NumberField(
        label: "Port",
        value: this.widget.config.port,
        onUpdate: _updatePort,
        min: 1024,
        max: 49151,
        fractions: false,
      ),
      TextPropertyField(
        label: "Path",
        value: this.widget.config.path,
        onUpdate: _updatePath,
      ),
      EnumField(
          label: "Argument Type",
          initialValue: this.widget.config.argumentType.value,
          items: OscNodeConfig_ArgumentType.values.map((v) => SelectOption(value: v.value, label: v.name)).toList(),
          onUpdate: _updateArgumentType,
      )
    ]);
  }

  void _updateHost(String host) {
    log("_updateHost $host", name: "OscProperties");
    setState(() {
      state.host = host;
      widget.onUpdate(state);
    });
  }

  void _updatePort(num port) {
    log("_updatePort $port", name: "OscProperties");
    int value = port.toInt();
    setState(() {
      state.port = value;
      widget.onUpdate(state);
    });
  }

  void _updatePath(String path) {
    log("_updatePath $path", name: "OscProperties");
    setState(() {
      state.path = path;
      widget.onUpdate(state);
    });
  }

  void _updateArgumentType(int argumentTypeValue) {
    log("_updateArgumentType $argumentTypeValue", name: "OscProperties");
    setState(() {
      state.argumentType = OscNodeConfig_ArgumentType.valueOf(argumentTypeValue)!;
      widget.onUpdate(state);
    });
  }
}

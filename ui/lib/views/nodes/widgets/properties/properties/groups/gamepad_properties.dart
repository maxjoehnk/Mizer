import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class GamepadProperties extends StatefulWidget {
  final GamepadNodeConfig config;
  final Function(GamepadNodeConfig) onUpdate;

  GamepadProperties(this.config, {required this.onUpdate});

  @override
  _GamepadPropertiesState createState() => _GamepadPropertiesState(config);
}

class _GamepadPropertiesState extends State<GamepadProperties> {
  GamepadNodeConfig state;
  List<Connection> gamepads = [];

  _GamepadPropertiesState(this.state);

  @override
  void didUpdateWidget(GamepadProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Gamepad", children: [
      EnumField<String>(
        label: "Device",
        initialValue: widget.config.deviceId,
        items: gamepads.map((e) => SelectOption(value: e.gamepad.id, label: e.name)).toList(),
        onUpdate: _updateDevice,
      ),
      EnumField(
        label: "Control",
        initialValue: widget.config.control,
        items: GamepadNodeConfig_Control.values
            .map((e) => SelectOption(value: e, label: e.name.toCapitalCase()))
            .toList(),
        onUpdate: _updateControl,
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _fetchGamepads();
  }

  @override
  void activate() {
    super.activate();
    _fetchGamepads();
  }

  @override
  void reassemble() {
    super.reassemble();
    _fetchGamepads();
  }

  Future _fetchGamepads() async {
    var connectionsApi = context.read<ConnectionsApi>();
    var connections = await connectionsApi.getConnections();
    this.setState(() {
      this.gamepads =
          connections.connections.where((connection) => connection.hasGamepad()).toList();
    });
  }

  void _updateDevice(String device) {
    log("_updateDevice $device", name: "GamepadProperties");
    setState(() {
      state.deviceId = device;
      widget.onUpdate(state);
    });
  }

  void _updateControl(GamepadNodeConfig_Control control) {
    log("_updateControl $control", name: "GamepadProperties");
    setState(() {
      state.control = control;
      widget.onUpdate(state);
    });
  }
}

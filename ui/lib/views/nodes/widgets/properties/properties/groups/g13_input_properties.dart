import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../fields/enum_field.dart';
import '../property_group.dart';

class G13InputProperties extends StatefulWidget {
  final G13InputNodeConfig config;
  final Function(G13InputNodeConfig) onUpdate;

  G13InputProperties(this.config, {required this.onUpdate});

  @override
  _G13InputPropertiesState createState() => _G13InputPropertiesState(config);
}

class _G13InputPropertiesState extends State<G13InputProperties> {
  G13InputNodeConfig state;
  List<Connection> devices = [];

  _G13InputPropertiesState(this.state);

  @override
  void didUpdateWidget(G13InputProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "G13Input", children: [
      EnumField<String>(
        label: "Device",
        initialValue: widget.config.deviceId,
        items: devices.map((e) => SelectOption(value: e.g13.id, label: e.name)).toList(),
        onUpdate: _updateDevice,
      ),
      EnumField(
        label: "Key",
        initialValue: widget.config.key,
        items: G13InputNodeConfig_Key.values.map((e) => SelectOption(value: e, label: e.name)).toList(),
        onUpdate: _updateKey,
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _fetchG13Devices();
  }

  @override
  void activate() {
    super.activate();
    _fetchG13Devices();
  }

  @override
  void reassemble() {
    super.reassemble();
    _fetchG13Devices();
  }

  Future _fetchG13Devices() async {
    var connectionsApi = context.read<ConnectionsApi>();
    var connections = await connectionsApi.getConnections();
    this.setState(() {
      this.devices = connections.connections.where((connection) => connection.hasG13()).toList();
    });
  }

  void _updateDevice(String device) {
    log("_updateDevice $device", name: "G13InputProperties");
    setState(() {
      state.deviceId = device;
      widget.onUpdate(state);
    });
  }

  void _updateKey(G13InputNodeConfig_Key key) {
    log("_updateKey $key", name: "G13InputProperties");
    setState(() {
      state.key = key;
      widget.onUpdate(state);
    });
  }
}

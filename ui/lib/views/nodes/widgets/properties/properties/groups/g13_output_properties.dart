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

class G13OutputProperties extends StatefulWidget {
  final G13OutputNodeConfig config;
  final Function(G13OutputNodeConfig) onUpdate;

  G13OutputProperties(this.config, {required this.onUpdate});

  @override
  _G13OutputPropertiesState createState() => _G13OutputPropertiesState(config);
}

class _G13OutputPropertiesState extends State<G13OutputProperties> {
  G13OutputNodeConfig state;
  List<Connection> devices = [];

  _G13OutputPropertiesState(this.state);

  @override
  void didUpdateWidget(G13OutputProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "G13Output", children: [
      EnumField<String>(
        label: "Device",
        initialValue: widget.config.deviceId,
        items: devices.map((e) => SelectOption(value: e.g13.id, label: e.name)).toList(),
        onUpdate: _updateDevice,
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
    log("_updateDevice $device", name: "G13OutputProperties");
    setState(() {
      state.deviceId = device;
      widget.onUpdate(state);
    });
  }
}

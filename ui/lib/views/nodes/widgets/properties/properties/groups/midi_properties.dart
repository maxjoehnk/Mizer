import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/enum_field.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../number_field.dart';
import '../property_group.dart';

class MidiProperties extends StatefulWidget {
  final MidiNodeConfig config;
  final Function(MidiNodeConfig) onUpdate;

  MidiProperties(this.config, {required this.onUpdate});

  @override
  _MidiPropertiesState createState() => _MidiPropertiesState(config);
}

class _MidiPropertiesState extends State<MidiProperties> {
  MidiNodeConfig state;
  List<Connection> midiDevices = [];

  _MidiPropertiesState(this.state);

  @override
  void didUpdateWidget(MidiProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }
  

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "MIDI", children: [
      EnumField(
        label: "Device",
        initialValue: widget.config.device,
        items: midiDevices.map((e) => SelectOption(value: e.name, label: e.name)).toList(),
        onUpdate: _updateDevice,
      ),
      NumberField(
        label: "Channel",
        value: this.widget.config.channel,
        onUpdate: _updateChannel,
        min: 1,
        max: 16,
        fractions: false,
      ),
      EnumField(
        label: "Mode",
        initialValue: this.widget.config.type.value,
        items: MidiNodeConfig_MidiType.values.map((v) => SelectOption(value: v.value, label: v.name)).toList(),
        onUpdate: _updateMode,
      ),
      NumberField(
        label: "Port",
        value: this.widget.config.port,
        onUpdate: _updatePort,
        min: 1,
        fractions: false,
      ),
      NumberField(
        label: "Range From",
        value: this.widget.config.rangeFrom,
        onUpdate: _updateRangeFrom,
        min: 1,
        max: 255,
        fractions: false,
      ),
      NumberField(
        label: "Range To",
        value: this.widget.config.rangeTo,
        onUpdate: _updateRangeTo,
        min: 1,
        max: 255,
        fractions: false,
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _fetchMidiConnections();
  }

  @override
  void activate() {
    super.activate();
    _fetchMidiConnections();
  }

  @override
  void reassemble() {
    super.reassemble();
    _fetchMidiConnections();
  }

  Future _fetchMidiConnections() async {
    var connections = await context.read<ConnectionsApi>().getConnections();
    this.setState(() {
      this.midiDevices = connections.connections.where((connection) => connection.hasMidi()).toList();
    });
  }

  void _updateChannel(num channel) {
    log("_updateChannel $channel", name: "MidiProperties");
    int value = channel.toInt();
    setState(() {
      state.channel = value;
      widget.onUpdate(state);
    });
  }

  void _updateMode(int modeValue) {
    log("_updateMode $modeValue", name: "MidiProperties");
    setState(() {
      state.type = MidiNodeConfig_MidiType.valueOf(modeValue)!;
      widget.onUpdate(state);
    });
  }

  void _updatePort(num port) {
    log("_updatePort $port", name: "MidiProperties");
    int value = port.toInt();
    setState(() {
      state.port = value;
      widget.onUpdate(state);
    });
  }

  void _updateRangeFrom(num rangeFrom) {
    log("_updateRangeFrom $rangeFrom", name: "MidiProperties");
    int value = rangeFrom.toInt();
    setState(() {
      state.rangeFrom = value;
      widget.onUpdate(state);
    });
  }

  void _updateRangeTo(num rangeTo) {
    log("_updateRangeTo $rangeTo", name: "MidiProperties");
    int value = rangeTo.toInt();
    setState(() {
      state.rangeTo = value;
      widget.onUpdate(state);
    });
  }

  void _updateDevice(String device) {
    log("_updateDevice $device", name: "MidiProperties");
    setState(() {
      state.device = device;
      widget.onUpdate(state);
    });
  }
}

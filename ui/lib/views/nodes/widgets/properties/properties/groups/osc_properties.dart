import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../fields/enum_field.dart';
import '../fields/text_field.dart';
import '../property_group.dart';

class OscProperties extends StatefulWidget {
  final OscNodeConfig config;
  final Function(OscNodeConfig) onUpdate;

  OscProperties(this.config, {required this.onUpdate});

  @override
  _OscPropertiesState createState() => _OscPropertiesState(config);
}

class _OscPropertiesState extends State<OscProperties> {
  OscNodeConfig state;
  List<Connection> connections = [];

  _OscPropertiesState(this.state);

  @override
  void didUpdateWidget(OscProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "OSC", children: [
      EnumField<String>(
        label: "Connection",
        initialValue: widget.config.connection,
        items: connections.map((e) => SelectOption(value: e.osc.connectionId, label: e.name)).toList(),
        onUpdate: _updateConnection,
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

  @override
  void initState() {
    super.initState();
    _fetchConnections();
  }

  @override
  void activate() {
    super.activate();
    _fetchConnections();
  }

  @override
  void reassemble() {
    super.reassemble();
    _fetchConnections();
  }

  Future _fetchConnections() async {
    var connectionsApi = context.read<ConnectionsApi>();
    var connections = await connectionsApi.getConnections();
    this.setState(() {
      this.connections = connections.connections.where((connection) => connection.hasOsc()).toList();
    });
  }

  void _updateConnection(String connectionId) {
    log("_updateConnection $connectionId", name: "OscProperties");
    setState(() {
      state.connection = connectionId;
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

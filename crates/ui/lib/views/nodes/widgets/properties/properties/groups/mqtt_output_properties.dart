import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/fields/checkbox_field.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../fields/enum_field.dart';
import '../fields/text_field.dart';
import '../property_group.dart';

class MqttOutputProperties extends StatefulWidget {
  final MqttOutputNodeConfig config;
  final Function(MqttOutputNodeConfig) onUpdate;

  MqttOutputProperties(this.config, {required this.onUpdate});

  @override
  _MqttOutputPropertiesState createState() => _MqttOutputPropertiesState(config);
}

class _MqttOutputPropertiesState extends State<MqttOutputProperties> {
  MqttOutputNodeConfig state;
  List<Connection> connections = [];

  _MqttOutputPropertiesState(this.state);

  @override
  void didUpdateWidget(MqttOutputProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "MQTT Output", children: [
      EnumField<String>(
        label: "Connection",
        initialValue: widget.config.connection,
        items: connections
            .map((e) => SelectOption(value: e.mqtt.connectionId, label: e.name))
            .toList(),
        onUpdate: _updateConnection,
      ),
      TextPropertyField(
        label: "Path",
        value: this.widget.config.path,
        onUpdate: _updatePath,
      ),
      CheckboxField(
        label: "Retain",
        value: this.widget.config.retain,
        onUpdate: _updateRetain,
      ),
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
      this.connections =
          connections.connections.where((connection) => connection.hasMqtt()).toList();
    });
  }

  void _updateConnection(String connectionId) {
    log("_updateConnection $connectionId", name: "MqttOutputProperties");
    setState(() {
      state.connection = connectionId;
      widget.onUpdate(state);
    });
  }

  void _updatePath(String path) {
    log("_updatePath $path", name: "MqttOutputProperties");
    setState(() {
      state.path = path;
      widget.onUpdate(state);
    });
  }

  void _updateRetain(bool retain) {
    log("_updateRetain $retain", name: "MqttOutputProperties");
    setState(() {
      state.retain = retain;
      widget.onUpdate(state);
    });
  }
}

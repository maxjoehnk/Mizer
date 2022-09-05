import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/enum_field.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:provider/provider.dart';

import '../property_group.dart';
import '../text_field.dart';

class MqttInputProperties extends StatefulWidget {
  final MqttInputNodeConfig config;
  final Function(MqttInputNodeConfig) onUpdate;

  MqttInputProperties(this.config, {required this.onUpdate});

  @override
  _MqttInputPropertiesState createState() => _MqttInputPropertiesState(config);
}

class _MqttInputPropertiesState extends State<MqttInputProperties> {
  MqttInputNodeConfig state;
  List<Connection> connections = [];

  _MqttInputPropertiesState(this.state);

  @override
  void didUpdateWidget(MqttInputProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "MQTT Input", children: [
      EnumField<String>(
        label: "Connection",
        initialValue: widget.config.connection,
        items: connections.map((e) => SelectOption(value: e.mqtt.connectionId, label: e.name)).toList(),
        onUpdate: _updateConnection,
      ),
      TextPropertyField(
        label: "Path",
        value: this.widget.config.path,
        onUpdate: _updatePath,
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
      this.connections = connections.connections.where((connection) => connection.hasMqtt()).toList();
    });
  }

  void _updateConnection(String connectionId) {
    log("_updateConnection $connectionId", name: "MqttInputProperties");
    setState(() {
      state.connection = connectionId;
      widget.onUpdate(state);
    });
  }

  void _updatePath(String path) {
    log("_updatePath $path", name: "MqttInputProperties");
    setState(() {
      state.path = path;
      widget.onUpdate(state);
    });
  }

}

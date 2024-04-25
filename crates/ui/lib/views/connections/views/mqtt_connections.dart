import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

import '../dialogs/add_mqtt_connection.dart';

class MqttConnectionsView extends StatefulWidget {
  final List<Connection> connections;
  final Function() onRefresh;

  const MqttConnectionsView({super.key, required this.connections, required this.onRefresh});

  @override
  State<MqttConnectionsView> createState() => _MqttConnectionsViewState();
}

class _MqttConnectionsViewState extends State<MqttConnectionsView> {
  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "MQTT Connections".i18n,
      child: MizerTable(
          columns: [
            Text("Name".i18n, style: titleTheme),
            Text("URL".i18n, style: titleTheme),
            Text("Username".i18n, style: titleTheme),
            Text("Password".i18n, style: titleTheme),
          ],
          rows: _connections.map((c) => MizerTableRow(cells: [
            Text(c.name),
            Text(c.mqtt.url),
            Text(c.mqtt.username),
            Text(c.mqtt.password.isEmpty ? "" : "******"),
          ])).toList()),
      actions: [
        PanelActionModel(label: "Add MQTT".i18n, onClick: _addMqtt),
      ],
    );
  }

  _addMqtt() async {
    var value = await showDialog<MqttConnection>(
        context: context, builder: (context) => ConfigureMqttConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addMqtt(value);
    await widget.onRefresh();
  }

  ConnectionsApi get api {
    return context.read();
  }

  Iterable<Connection> get _connections {
    return widget.connections.where((c) => c.hasMqtt());
  }
}

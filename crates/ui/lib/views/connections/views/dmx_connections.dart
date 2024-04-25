import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

import '../dialogs/add_artnet_input_connection.dart';
import '../dialogs/add_artnet_output_connection.dart';
import '../dialogs/add_sacn_connection.dart';

class DmxConnectionsView extends StatefulWidget {
  final List<Connection> connections;
  final Function() onRefresh;

  const DmxConnectionsView({super.key, required this.connections, required this.onRefresh});

  @override
  State<DmxConnectionsView> createState() => _DmxConnectionsViewState();
}

class _DmxConnectionsViewState extends State<DmxConnectionsView> {
  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "DMX Connections".i18n,
      child: MizerTable(
        columns: [
          Text("Name".i18n, style: titleTheme),
          Text("Direction".i18n, style: titleTheme),
          Text("Type".i18n, style: titleTheme),
          Text("Address".i18n, style: titleTheme),
          Text("Port".i18n, style: titleTheme),
        ],
          rows: _connections.map((c) {
            if (c.hasDmxOutput()) {
              return _dmxOutput(c);
            }
            if (c.hasDmxInput()) {
              return _dmxInput(c);
            }
            return MizerTableRow(cells: []);
          }).toList()),
      actions: [
        PanelActionModel(label: "Add sACN Output".i18n, onClick: _addSacnOutput),
        PanelActionModel(label: "Add Artnet Output".i18n, onClick: _addArtnetOutput),
        PanelActionModel(label: "Add Artnet Input".i18n, onClick: _addArtnetInput),
      ],
    );
  }

  MizerTableRow _dmxOutput(Connection connection) {
    return MizerTableRow(cells: [
      Text(connection.name),
      Text("Output".i18n),
      Text(connection.dmxOutput.hasArtnet() ? "Artnet".i18n : "sACN".i18n),
      Text(connection.dmxOutput.hasArtnet() ? connection.dmxOutput.artnet.host : ""),
      Text(connection.dmxOutput.hasArtnet() ? connection.dmxOutput.artnet.port.toString() : ""),
    ]);
  }

  MizerTableRow _dmxInput(Connection connection) {
    return MizerTableRow(cells: [
      Text(connection.name),
      Text("Input".i18n),
      Text(connection.dmxInput.hasArtnet() ? "Artnet".i18n : ""),
      Text(connection.dmxInput.hasArtnet() ? connection.dmxInput.artnet.host : ""),
      Text(connection.dmxInput.hasArtnet() ? connection.dmxInput.artnet.port.toString() : ""),
    ]);
  }

  _addSacnOutput() async {
    var value = await showDialog<SacnConfig>(
        context: context, builder: (context) => ConfigureSacnConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addSacnOutput(value);
    await widget.onRefresh();
  }

  _addArtnetOutput() async {
    var value = await showDialog<ArtnetOutputConfig>(
        context: context, builder: (context) => ConfigureArtnetOutputConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addArtnetOutput(value);
    await widget.onRefresh();
  }

  _addArtnetInput() async {
    var value = await showDialog<ArtnetInputConfig>(
        context: context, builder: (context) => ConfigureArtnetInputConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addArtnetInput(value);
    await widget.onRefresh();
  }

  ConnectionsApi get api {
    return context.read();
  }

  Iterable<Connection> get _connections {
    return widget.connections.where((c) => c.hasDmxInput() || c.hasDmxOutput());
  }
}

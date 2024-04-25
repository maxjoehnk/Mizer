import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

import '../dialogs/add_osc_connection.dart';

class OscConnectionsView extends StatefulWidget {
  final List<Connection> connections;
  final Function() onRefresh;

  const OscConnectionsView({super.key, required this.connections, required this.onRefresh});

  @override
  State<OscConnectionsView> createState() => _OscConnectionsViewState();
}

class _OscConnectionsViewState extends State<OscConnectionsView> {
  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "OSC Connections".i18n,
      child: MizerTable(
          columns: [
            Text("Name".i18n, style: titleTheme),
            Text("Input".i18n, style: titleTheme),
            Text("Output".i18n, style: titleTheme),
          ],
          rows: _connections.map((c) => MizerTableRow(cells: [
            Text(c.name),
            Text("0.0.0.0:${c.osc.inputPort}"),
            Text("${c.osc.outputAddress}:${c.osc.outputPort}"),
          ])).toList()),
      actions: [
        PanelActionModel(label: "Add OSC".i18n, onClick: _addOsc),
      ],
    );
  }

  _addOsc() async {
    var value = await showDialog<OscConnection>(
        context: context, builder: (context) => ConfigureOscConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addOsc(value);
    await widget.onRefresh();
  }

  ConnectionsApi get api {
    return context.read();
  }

  Iterable<Connection> get _connections {
    return widget.connections.where((c) => c.hasOsc());
  }
}

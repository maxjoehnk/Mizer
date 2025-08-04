import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/dialogs/osc_monitor.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/connections/dialogs/add_osc_connection.dart';
import 'package:mizer/views/connections/dialogs/delete_connection.dart';

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
          columnWidths: {
            3: FixedColumnWidth(128),
          },
          columns: [
            Text("Name".i18n, style: titleTheme),
            Text("Input".i18n, style: titleTheme),
            Text("Output".i18n, style: titleTheme),
            Container(),
          ],
          rows: _connections
              .map((c) => MizerTableRow(cells: [
                    Text(c.osc.name),
                    Text("0.0.0.0:${c.osc.inputPort}"),
                    Text("${c.osc.outputAddress}:${c.osc.outputPort}"),
                    Row(children: [
                      MizerIconButton(
                          icon: MdiIcons.formatListBulleted,
                          label: "Monitor".i18n,
                          onClick: () => _showOscMonitor(c)),
                      MizerIconButton(
                          icon: Icons.edit, label: "Edit".i18n, onClick: () => _onConfigure(c)),
                      MizerIconButton(
                          icon: Icons.delete, label: "Delete".i18n, onClick: () => _onDelete(c)),
                    ])
                  ]))
              .toList()),
      actions: [
        PanelActionModel(label: "Add OSC".i18n, onClick: _addOsc),
      ],
    );
  }

  _showOscMonitor(Connection connection) {
    openDialog(context, OscMonitorDialog(connection));
  }

  _onDelete(Connection connection) async {
    bool? result = await DeleteConnectionDialog.show(context, connection);
    if (result == true) {
      await api.deleteConnection(connection);
      await widget.onRefresh();
    }
  }

  _onConfigure(Connection connection) async {
    var value = await showDialog<OscConnection>(
        context: context,
        builder: (context) => ConfigureOscConnectionDialog(config: connection.osc));
    if (value == null) {
      return null;
    }
    value.connectionId = connection.osc.connectionId;
    await api.configureConnection(ConfigureConnectionRequest(osc: value));
    await widget.onRefresh();
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

import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class HidConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const HidConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "HID Devices".i18n,
      child: MizerTable(
          columns: [
            Text("Name".i18n, style: titleTheme),
          ],
          rows: _connections.map((c) => MizerTableRow(cells: [Text(c.name)])).toList()),
    );
  }

  Iterable<Connection> get _connections {
    return connections.where((c) => c.hasX1() || c.hasG13());
  }
}

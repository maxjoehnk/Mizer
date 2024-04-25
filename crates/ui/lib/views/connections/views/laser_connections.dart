import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class LaserConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const LaserConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "Laser Connections".i18n,
      child: MizerTable(
          columns: [
            Text("Name".i18n, style: titleTheme),
            Text("Type".i18n, style: titleTheme),
            Text("Firmware".i18n, style: titleTheme),
          ],
          rows: _connections.map((c) {
            if (c.hasEtherDream()) {
              return _etherDream(c);
            }
            if (c.hasHelios()) {
              return _helios(c);
            }
            return MizerTableRow(cells: []);
          }).toList()),
    );
  }

  MizerTableRow _etherDream(Connection connection) {
    return MizerTableRow(cells: [
      Text(connection.name),
      Text("Ether Dream".i18n),
      Container(),
    ]);
  }

  MizerTableRow _helios(Connection connection) {
    return MizerTableRow(cells: [
      Text(connection.name),
      Text("Helios".i18n),
      Text(connection.helios.firmware.toString()),
    ]);
  }

  Iterable<Connection> get _connections {
    return connections.where((c) => c.hasEtherDream() || c.hasHelios());
  }
}

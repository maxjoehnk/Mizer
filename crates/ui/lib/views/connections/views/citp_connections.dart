import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class CitpConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const CitpConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "CITP".i18n,
      child: MizerTable(
        columns: [
          Text("Name".i18n, style: titleTheme),
          Text("State".i18n, style: titleTheme),
          Text("Kind".i18n, style: titleTheme),
        ],
        rows: _connections
            .map((c) => MizerTableRow(cells: [
                  Text(c.citp.name),
                  Text(c.citp.state),
                  Text(formatKind(c.citp.kind)),
                ]))
            .toList(),
      ),
    );
  }

  Iterable<Connection> get _connections {
    return connections.where((c) => c.hasCitp());
  }

  String formatKind(CitpConnection_CitpKind kind) {
    switch (kind) {
      case CitpConnection_CitpKind.CITP_KIND_LIGHTING_CONSOLE:
        return "Lighting Console".i18n;
      case CitpConnection_CitpKind.CITP_KIND_MEDIA_SERVER:
        return "Media Server".i18n;
      case CitpConnection_CitpKind.CITP_KIND_VISUALIZER:
        return "Visualizer".i18n;
      case CitpConnection_CitpKind.CITP_KIND_UNKNOWN:
      default:
        return "Unknown".i18n;
    }
  }
}

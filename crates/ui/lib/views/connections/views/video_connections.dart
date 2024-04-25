import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

class VideoConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const VideoConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "Video Connections".i18n,
      child: MizerTable(
          columns: [
            Text("Name".i18n, style: titleTheme),
            Text("Type".i18n, style: titleTheme),
          ],
          rows: _connections.map((c) {
            if (c.hasNdiSource()) {
              return _ndi(c);
            }
            if (c.hasWebcam()) {
              return _webcam(c);
            }
            return MizerTableRow(cells: []);
          }).toList()),
    );
  }

  MizerTableRow _ndi(Connection connection) {
    return MizerTableRow(cells: [
      Text(connection.name),
      Text("NDI".i18n),
    ]);
  }

  MizerTableRow _webcam(Connection connection) {
    return MizerTableRow(cells: [
      Text(connection.name),
      Text("Webcam".i18n),
    ]);
  }

  Iterable<Connection> get _connections {
    return connections.where((c) => c.hasNdiSource() || c.hasWebcam());
  }
}

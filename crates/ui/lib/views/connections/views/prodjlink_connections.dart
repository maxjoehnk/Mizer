import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/types/prodjlink_connection.dart';
import 'package:mizer/widgets/panel.dart';

class ProDJLinkConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const ProDJLinkConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Pioneer ProDJLink Connections".i18n,
      child: ListView(
        children: connections
        .where((c) => c.hasDjm() || c.hasCdj())
        .map((c) {
          if (c.hasCdj()) {
            return ProDJLinkConnectionView(device: c.cdj);
          }
          return Container();
        }).toList(),
      ),
    );
  }
}

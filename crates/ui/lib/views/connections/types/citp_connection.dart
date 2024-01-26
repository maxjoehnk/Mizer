import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

class CitpConnectionView extends StatelessWidget {
  final CitpConnection connection;

  CitpConnectionView({required this.connection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text("Kind: ${formatKind(connection.kind)}".i18n),
        Text("State: ${connection.state}".i18n),
      ], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  String formatKind(CitpConnection_CitpKind kind) {
    switch (kind) {
      case CitpConnection_CitpKind.CITP_KIND_LIGHTING_CONSOLE:
        return "Lighting Console";
      case CitpConnection_CitpKind.CITP_KIND_MEDIA_SERVER:
        return "Media Server";
      case CitpConnection_CitpKind.CITP_KIND_VISUALIZER:
        return "Visualizer";
      case CitpConnection_CitpKind.CITP_KIND_UNKNOWN:
      default:
        return "Unknown";
    }
  }
}

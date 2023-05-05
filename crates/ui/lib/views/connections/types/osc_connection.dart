import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

class OscConnectionView extends StatelessWidget {
  final OscConnection connection;

  OscConnectionView({required this.connection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Text("Output: ${connection.outputAddress}:${connection.outputPort}".i18n),
        Text("Input: 0.0.0.0:${connection.inputPort}".i18n),
      ], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }
}

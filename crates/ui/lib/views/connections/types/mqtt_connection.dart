import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

class MqttConnectionView extends StatelessWidget {
  final MqttConnection connection;

  MqttConnectionView({required this.connection});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text("URL: ${connection.url}".i18n),
        Text("Username: ${connection.username}".i18n),
        Text("Password: ${connection.password.isEmpty ? "" : "******"}".i18n),
      ], crossAxisAlignment: CrossAxisAlignment.start),
    );
  }
}

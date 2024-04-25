import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/types/gamepad_connection.dart';
import 'package:mizer/widgets/panel.dart';

class GamepadConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const GamepadConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Gamepads".i18n,
      child: ListView(
        children: connections
        .where((c) => c.hasGamepad())
        .map((c) {
          if (c.hasCdj()) {
            return GamepadConnectionView(device: c.gamepad);
          }
          return Container();
        }).toList(),
      ),
    );
  }
}

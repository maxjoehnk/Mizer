import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';

import 'items/gamepad_view.dart';

class GamepadConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const GamepadConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Gamepads".i18n,
      child: ListView(
        children: connections.where((c) => c.hasGamepad() || c.hasG13()).map((c) {
          if (c.hasGamepad()) {
            return GamepadConnectionView(device: c.gamepad);
          }
          if (c.hasG13()) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(c.name),
            );
          }

          return Container();
        }).toList(),
      ),
    );
  }
}

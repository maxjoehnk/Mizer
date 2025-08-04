import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/panel.dart';

import 'package:mizer/views/connections/views/items/gamepad_view.dart';

class GamepadConnectionsView extends StatelessWidget {
  final List<Connection> connections;

  const GamepadConnectionsView({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Gamepads".i18n,
      child: ListView(
        children: connections.where((c) => c.hasGamepad()).map((c) => GamepadConnectionView(device: c.gamepad)).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/plugin/app.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/tile.dart';

class PowerDialog extends StatelessWidget {
  final ApplicationPluginApi applicationApi;

  const PowerDialog({super.key, required this.applicationApi});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Shutdown Menu",
        content: Row(children: [
          PowerTile(icon: MdiIcons.power, title: "Shutdown", onTap: () => applicationApi.shutdown()),
          PowerTile(icon: MdiIcons.restart, title: "Reboot", onTap: () => applicationApi.reboot()),
          PowerTile(icon: MdiIcons.exitToApp, title: "Exit", onTap: () => applicationApi.exit()),
        ]));
  }
}

class PowerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  const PowerTile({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Tile(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(title),
        ],
      ), onClick: onTap),
    );
  }
}

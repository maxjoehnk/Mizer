import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/plugin/app.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/dialog/dialog_tile.dart';
import 'package:mizer/widgets/dialog/grid_dialog.dart';
import 'package:mizer/i18n.dart';

class PowerDialog extends StatelessWidget {
  final ApplicationPluginApi applicationApi;

  const PowerDialog({super.key, required this.applicationApi});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Shutdown Menu".i18n,
        content: DialogTileGrid(
          columns: 3,
          children: [
            PowerTile(
                icon: MdiIcons.power, title: "Shutdown".i18n, onTap: () => applicationApi.shutdown()),
            PowerTile(
                icon: MdiIcons.restart, title: "Reboot".i18n, onTap: () => applicationApi.reboot()),
            PowerTile(icon: MdiIcons.exitToApp, title: "Exit".i18n, onTap: () => applicationApi.exit()),
          ],
        ));
  }
}

class PowerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  const PowerTile({super.key, required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DialogTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
        onClick: onTap);
  }
}

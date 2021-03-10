import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:menubar/menubar.dart';

import 'actions/actions.dart';
import 'actions/menu.dart';

class WindowMenu extends StatelessWidget {
  final Widget child;
  final List<Submenu> menu;

  WindowMenu({@required this.child, this.menu = const []});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, state) => child, future: setApplicationMenu(this.menu));
  }
}

class ApplicationMenu extends StatelessWidget {
  final Widget child;

  ApplicationMenu({@required this.child});

  @override
  Widget build(BuildContext context) {
    return WindowMenu(menu: [
      Submenu(label: "File", children: [
        MenuActionItem(
            label: "New Project",
            action: NewProjectIntent(),
            shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN)),
        MenuActionItem(
            label: "Open Project",
            action: OpenProjectIntent(),
            shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO)),
        MenuItem(label: "Close Project"),
        MenuDivider(),
        MenuItem(
            label: "Exit",
            shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ))
      ]),
      Submenu(label: "View", children: [
        MenuActionItem(label: "Layout", action: OpenViewIntent(View.Layout)),
        MenuActionItem(label: "Nodes", action: OpenViewIntent(View.Nodes)),
        MenuActionItem(label: "Fixtures", action: OpenViewIntent(View.Fixtures)),
        MenuActionItem(label: "Media", action: OpenViewIntent(View.Media)),
        MenuActionItem(label: "Devices", action: OpenViewIntent(View.Devices)),
        MenuActionItem(label: "Session", action: OpenViewIntent(View.Session)),
        MenuActionItem(label: "Settings", action: OpenViewIntent(View.Settings)),
      ])
    ], child: this.child);
  }
}

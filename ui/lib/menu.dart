import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:mizer/platform/platform.dart';

import 'actions/actions.dart';
import 'actions/menu.dart';
import 'api/contracts/session.dart';

class ApplicationMenu extends StatelessWidget {
  final Widget child;

  ApplicationMenu({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MenuBar(
        child: child,
        menu: Menu(items: [
          SubMenu(title: "File", children: [
            MenuItem(
                label: "New Project",
                action: () => context.read<SessionApi>().newProject(),
                shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN)),
            MenuActionItem(
                label: "Open Project",
                action: OpenProjectIntent(),
                shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO)),
            MenuItem(
                label: 'Save Project',
                action: () => context.read<SessionApi>().saveProject(),
                shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS)),
            MenuItem(label: 'Close Project', action: () => context.read<SessionApi>().closeProject()),
            MenuDivider(),
            MenuItem(label: 'Preferences'),
            MenuItem(
                label: "Exit",
                shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ))
          ]),
          SubMenu(title: 'View', children: [
            MenuActionItem(label: "Layout", action: OpenViewIntent(View.Layout)),
            MenuActionItem(label: "2D Plan", action: OpenViewIntent(View.Plan2D)),
            MenuActionItem(label: "PreViz", action: OpenViewIntent(View.PreViz)),
            MenuActionItem(label: "Nodes", action: OpenViewIntent(View.Nodes)),
            MenuActionItem(label: "Sequences", action: OpenViewIntent(View.Sequences)),
            MenuActionItem(label: "Fixtures", action: OpenViewIntent(View.Fixtures)),
            MenuActionItem(label: "Media", action: OpenViewIntent(View.Media)),
            MenuActionItem(label: "Connections", action: OpenViewIntent(View.Connections)),
            MenuActionItem(label: "Session", action: OpenViewIntent(View.Session)),
          ])
        ]));
  }
}

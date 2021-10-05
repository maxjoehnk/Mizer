import 'package:flutter/widgets.dart';
import 'package:menubar/menubar.dart' as menubar;

import '../platform.dart';

class StandaloneMenuBar extends StatelessWidget {
  final Widget child;
  final Menu menu;

  const StandaloneMenuBar({required this.child, required this.menu, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, state) => child, future: _setupMenu());
  }

  _setupMenu() {
    var menus = menu.items
        .map((e) => menubar.Submenu(
            label: (e as SubMenu).title,
            children: (e as SubMenu).children.map((i) {
              if (i is MenuDivider) {
                return menubar.MenuDivider();
              }
              if (i is MenuItem) {
                return menubar.MenuItem(
                  label: i.label,
                  onClicked: i.action,
                  shortcut: i.shortcut,
                );
              }
              throw new AssertionError("Invalid menu item");
            }).toList()))
        .toList();

    return menubar.setApplicationMenu(menus);
  }
}

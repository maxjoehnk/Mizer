import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart' as nativeshell;

import '../platform.dart';

class IntegratedMenuBar extends StatelessWidget {
  final Widget child;
  final Menu menu;

  const IntegratedMenuBar({required this.child, required this.menu, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      nativeshell.MenuBar(menu: _convertMenu(), itemBuilder: _buildMenuBarItem),
      Expanded(child: child),
    ]);
  }

  nativeshell.Menu _convertMenu() {
    var menus = menu.items
        .map((e) => nativeshell.MenuItem.children(
            title: "&${(e as SubMenu).title}",
            children: (e as SubMenu).children.map((i) {
              if (i is MenuDivider) {
                return nativeshell.MenuItem.separator();
              }
              if (i is MenuItem) {
                return nativeshell.MenuItem(title: i.label, action: i.action);
              }
              throw new AssertionError("Invalid menu item");
            }).toList()))
        .toList();

    return nativeshell.Menu(() => menus);
  }

  Widget _buildMenuBarItem(
      BuildContext context, Widget child, nativeshell.MenuItemState itemState) {
    var theme = Theme.of(context);
    Color background;
    Color foreground;
    switch (itemState) {
      case nativeshell.MenuItemState.regular:
        background = Colors.transparent;
        foreground = Colors.white.withOpacity(0.8);
        break;
      case nativeshell.MenuItemState.hovered:
        background = theme.primaryColor.withOpacity(0.2);
        foreground = Colors.white;
        break;
      case nativeshell.MenuItemState.selected:
        background = theme.primaryColor.withOpacity(0.8);
        foreground = Colors.white;
        break;
      case nativeshell.MenuItemState.disabled:
        background = Colors.transparent;
        foreground = Colors.white.withOpacity(0.5);
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: background,
      child: DefaultTextStyle.merge(
        style: TextStyle(color: foreground),
        child: child,
      ),
    );
  }
}

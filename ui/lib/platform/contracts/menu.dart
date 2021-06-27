import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Menu {
  final List<MenuBaseItem> items;

  Menu({ this.items });
}

abstract class MenuBaseItem {}

class MenuItem extends MenuBaseItem {
  final String label;
  final Function action;
  final LogicalKeySet shortcut;

  MenuItem({ @required this.label, this.action, this.shortcut });
}

class SubMenu extends MenuBaseItem {
  final String title;
  final List<MenuBaseItem> children;

  SubMenu({ this.title, this.children });
}

class MenuDivider extends MenuBaseItem {}

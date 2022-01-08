import 'package:flutter/cupertino.dart';

class Menu {
  final List<MenuBaseItem> items;

  Menu({ required this.items });
}

abstract class MenuBaseItem {}

class MenuItem extends MenuBaseItem {
  final String label;
  final bool? disabled;
  final Function()? action;
  final LogicalKeySet? shortcut;

  MenuItem({ required this.label, this.disabled, this.action, this.shortcut });
}

class SubMenu extends MenuBaseItem {
  final String title;
  final List<MenuBaseItem> children;

  SubMenu({ required this.title, required this.children });
}

class MenuDivider extends MenuBaseItem {}

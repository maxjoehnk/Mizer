import 'package:flutter/foundation.dart';

class Menu {
  final List<MenuItem> items;

  Menu({ this.items });
}

class MenuItem {
  final String title;
  final Function action;

  MenuItem({ @required this.title, this.action });
}

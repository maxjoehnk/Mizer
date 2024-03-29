import 'package:flutter/widgets.dart';
import 'package:mizer/platform/integrated/menu_bar.dart';

import '../platform.dart';
import 'menu.dart';

class MenuBar extends StatelessWidget {
  final Widget child;
  final Menu menu;
  const MenuBar({Key? key, required this.menu, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntegratedMenuBar(menu: menu, child: child);
  }
}

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
    if (context.platform.isStandalone) {
      throw Exception("Not implemented");
    }else {
      return IntegratedMenuBar(menu: menu, child: child);
    }
  }
}

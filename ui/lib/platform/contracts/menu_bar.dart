import 'package:flutter/widgets.dart';
import 'package:mizer/platform/integrated/menu_bar.dart';
import 'package:mizer/platform/standalone/menu_bar.dart';
import 'package:mizer/platform/standalone/platform.dart';

import '../platform.dart';
import 'menu.dart';

class MenuBar extends StatelessWidget {
  final Widget child;
  final Menu menu;
  const MenuBar({Key key, this.menu, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.platform is StandalonePlatform) {
      return StandaloneMenuBar(menu: menu, child: child);
    }else {
      return IntegratedMenuBar(menu: menu, child: child);
    }
  }
}

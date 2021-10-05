import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/popup_menu/popup_menu_route.dart';

import '../platform.dart';
import 'menu.dart';

class StandalonePlatform extends Platform {
  @override
  showContextMenu({required BuildContext context, required Menu menu, required Offset position}) {
    Navigator.of(context)
        .push(PopupMenuRoute(position: position, child: MenuContainer(menu: menu)));
  }
}

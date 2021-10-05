// @dart=2.11
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/popup_menu/popup_menu_route.dart';

import '../platform.dart';
import 'menu.dart';

class StandalonePlatform extends Platform {
  @override
  showContextMenu({BuildContext context, Menu menu, Offset position}) {
    Navigator.of(context)
        .push(PopupMenuRoute(position: position, child: MenuContainer(menu: menu)));
  }
}

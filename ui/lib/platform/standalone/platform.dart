import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../platform.dart';
import 'menu.dart';

class StandalonePlatform implements Platform {
  @override
  showContextMenu({BuildContext context, Menu menu, Offset position}) {
    Navigator.of(context).push(MenuRoute(
      position: position,
      menu: menu,
    ));
  }
}

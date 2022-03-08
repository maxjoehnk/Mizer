import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/popup/popup_route.dart';

import '../platform.dart';
import 'menu.dart';

class StandalonePlatform extends Platform {
  @override
  showContextMenu({required BuildContext context, required Menu menu, required Offset position}) {
    Navigator.of(context)
        .push(MizerPopupRoute(position: position, child: MenuContainer(menu: menu)));
  }
}

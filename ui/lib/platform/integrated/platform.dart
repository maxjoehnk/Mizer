import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart' as nativeshell;

import '../platform.dart';
import 'menu.dart';

class IntegratedPlatform implements Platform {
  @override
  showContextMenu({ BuildContext context, Menu menu, Offset position }) {
    nativeshell.Window.of(context).showPopupMenu(menu.toNative(), position);
  }
}

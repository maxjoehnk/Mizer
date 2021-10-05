import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart' as nativeshell;

import '../platform.dart';
import 'menu.dart';

class IntegratedPlatform extends Platform {
  @override
  showContextMenu({ required BuildContext context, required Menu menu, required Offset position }) {
    nativeshell.Window.of(context).showPopupMenu(menu.toNative(), position);
  }
}

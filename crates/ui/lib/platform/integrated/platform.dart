import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart' as nativeshell;

import 'package:mizer/platform/platform.dart';
import 'package:mizer/platform/integrated/menu.dart';

class IntegratedPlatform extends Platform {
  @override
  showContextMenu({ required BuildContext context, required Menu menu, required Offset position }) {
    nativeshell.Window.of(context).showPopupMenu(menu.toNative(), position);
  }
}

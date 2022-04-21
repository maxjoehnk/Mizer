import 'package:flutter/cupertino.dart' hide MenuItem;
import 'package:mizer/platform/platform.dart';

class MenuActionItem extends MenuItem {
  MenuActionItem({required String label, required Intent action, LogicalKeySet? shortcut})
      : super(
            label: label,
            shortcut: shortcut,
            action: () {
              final BuildContext primaryContext = primaryFocus!.context!;
              return Actions.invoke(primaryContext, action);
            });
}

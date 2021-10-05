// @dart=2.11
import 'package:flutter/cupertino.dart';
import 'package:mizer/platform/platform.dart';

class MenuActionItem extends MenuItem {
  MenuActionItem({String label, Intent action, LogicalKeySet shortcut})
      : super(
            label: label,
            shortcut: shortcut,
            action: () {
              final BuildContext primaryContext = primaryFocus.context;
              return Actions.invoke(primaryContext, action);
            });
}

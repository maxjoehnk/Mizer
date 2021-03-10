import 'package:flutter/cupertino.dart';
import 'package:menubar/menubar.dart';

class MenuActionItem extends MenuItem {
  MenuActionItem({String label, Intent action, LogicalKeySet shortcut})
      : super(
            label: label,
            shortcut: shortcut,
            onClicked: () {
              final BuildContext primaryContext = primaryFocus.context;
              return Actions.invoke(primaryContext, action);
            });
}

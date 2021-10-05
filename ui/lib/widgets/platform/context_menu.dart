import 'package:flutter/widgets.dart';
import 'package:mizer/platform/platform.dart';

class ContextMenu extends StatelessWidget {
  final Widget? child;
  final Menu menu;

  const ContextMenu({this.child, required this.menu, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) => context.platform
          .showContextMenu(context: context, menu: menu, position: details.globalPosition),
      child: child,
    );
  }
}

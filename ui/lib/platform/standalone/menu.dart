import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/hoverable.dart';

import '../platform.dart';

class MenuRoute extends PopupRoute {
  final Offset position;
  final Menu menu;

  MenuRoute({@required this.position, this.menu});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    var theme = Theme.of(context).textTheme;
    return Stack(children: [
      Positioned(
        top: position.dy,
        left: position.dx,
        child: DefaultTextStyle(style: theme.bodyText2, child: MenuContainer(menu: menu)),
      )
    ]);
  }

  @override
  Duration get transitionDuration => Duration.zero;
}

class MenuContainer extends StatelessWidget {
  final Menu menu;

  const MenuContainer({this.menu, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(blurRadius: 4, offset: Offset(2, 2), color: Colors.black26)]),
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: menu.items.map((e) => MenuRowItem(item: e)).toList()),
    );
  }
}

class MenuRowItem extends StatelessWidget {
  final MenuItem item;

  const MenuRowItem({this.item, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onClick: () {
        Navigator.of(context).pop();
        item.action();
      },
      builder: (hovered) => Container(
        color: hovered ? Colors.grey.shade700 : null,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(item.label),
      ),
    );
  }
}

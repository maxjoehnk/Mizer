// @dart=2.11
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/hoverable.dart';

import '../platform.dart';

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
      onTap: () {
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

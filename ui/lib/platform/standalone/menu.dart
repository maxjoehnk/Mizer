import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/widgets/hoverable.dart';

import '../platform.dart';

class MenuContainer extends StatelessWidget {
  final Menu menu;

  const MenuContainer({required this.menu, Key? key}) : super(key: key);

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
          children: menu.items.map((e) => MenuRowItem(item: e as MenuItem)).toList()),
    );
  }
}

class MenuRowItem extends StatelessWidget {
  final MenuItem item;

  const MenuRowItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      disabled: item.action == null || (item.disabled ?? false),
      onTap: () {
        Navigator.of(context).pop();
        if (item.action != null) {
          item.action!();
        }
      },
      builder: (hovered) => Container(
        color: hovered ? Colors.grey.shade700 : null,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(item.label),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';

class ListItem extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final bool? selected;

  const ListItem({super.key, required this.child, this.onTap, this.selected});

  factory ListItem.text(String text, {Function()? onTap, bool? selected}) {
    return ListItem(
      child: Text(text, style: TextStyle(fontSize: 15)),
      onTap: onTap,
      selected: selected,
    );
  }

  factory ListItem.twoLines({ required String title, required String subtitle, Function()? onTap, bool? selected}) {
    return ListItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 15)),
          Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.white54)),
        ],
      ),
      onTap: onTap,
      selected: selected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        onTap: onTap,
        builder: (hovered) => Container(
              color: (selected ?? false)
                  ? Grey800
                  : (hovered ? Grey700 : null),
              padding: const EdgeInsets.all(8),
              child: child,
            ));
  }
}

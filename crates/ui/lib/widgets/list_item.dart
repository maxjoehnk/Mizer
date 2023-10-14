import 'package:flutter/material.dart';
import 'package:mizer/widgets/hoverable.dart';

class ListItem extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final bool? selected;

  const ListItem({super.key, required this.child, this.onTap, this.selected});

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        onTap: onTap,
        builder: (hovered) => Container(
              color: (selected ?? false)
                  ? (hovered ? Colors.black26 : Colors.black12)
                  : (hovered ? Colors.black12 : null),
              padding: const EdgeInsets.all(8),
              child: child,
            ));
  }
}

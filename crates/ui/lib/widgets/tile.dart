import 'package:flutter/material.dart';

import 'hoverable.dart';

const double TILE_SIZE = 96;

class Tile extends StatelessWidget {
  final String? title;
  final Widget child;
  final Function()? onClick;

  const Tile({this.title, required this.child, this.onClick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
        builder: (hovered) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade800, width: 2),
                borderRadius: BorderRadius.circular(4),
                color: hovered ? Colors.grey.shade700 : Colors.grey.shade900),
            width: TILE_SIZE,
            height: TILE_SIZE,
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null)
                    Container(
                        color: Colors.grey.shade800,
                        child: Text(title!, textAlign: TextAlign.center)),
                  Expanded(child: child),
                ],
              ),
            ),
          );
        },
        onTap: this.onClick);
  }
}

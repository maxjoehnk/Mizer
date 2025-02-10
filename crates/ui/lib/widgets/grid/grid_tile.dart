import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/hoverable.dart';

class PanelGridTile extends StatelessWidget {
  final Widget child;
  final bool active;
  final bool selected;
  final bool empty;
  final Function()? onTap;
  final Function()? onSecondaryTap;
  final Function(TapDownDetails)? onSecondaryTapDown;

  const PanelGridTile({ required this.child, this.onTap, this.onSecondaryTap, this.onSecondaryTapDown, this.active = false, this.selected = false, this.empty = false, super.key});

  PanelGridTile.empty() : this(child: Container(), empty: true);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onTap,
      onSecondaryTap: onSecondaryTap,
      builder: (hovered) => Container(
        width: GRID_MAIN_SIZE,
        height: GRID_MAIN_SIZE,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: empty ? Color(0xFF303030) : (hovered ? Colors.grey.shade800 : Colors.grey.shade900),
        ),
        child: Stack(children: [
          if (selected) Container(
              width: GRID_MAIN_SIZE,
              height: GRID_MAIN_SIZE,
              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
          ),
          if (active) Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: GRID_MAIN_SIZE,
              height: 4,
              color: Colors.deepOrange.shade700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: child,
          )
        ]),
      ),
    );
  }
}

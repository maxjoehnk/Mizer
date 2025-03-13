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
        width: GRID_4_SIZE,
        height: GRID_4_SIZE,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: selected ? White : TileBorder,
              width: 2,
            )
          ),
          borderRadius: BorderRadius.circular(0),
          color: empty ? Grey800 : (selected ? Grey500 : (hovered ? Grey600 : Grey700)),
        ),
        child: Stack(children: [
          if (active) Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: GRID_4_SIZE,
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

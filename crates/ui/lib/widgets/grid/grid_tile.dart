import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/widgets/high_contrast_text.dart';
import 'package:mizer/widgets/hoverable.dart';

class PanelGridTile extends StatelessWidget {
  final Widget child;
  final bool interactive;
  final bool active;
  final bool selected;
  final bool empty;
  final Color? color;
  final int width;
  final int height;
  final Function()? onTap;
  final Function(TapDownDetails)? onTapDown;
  final Function(TapUpDetails)? onTapUp;
  final Function()? onSecondaryTap;
  final Function(TapDownDetails)? onSecondaryTapDown;

  const PanelGridTile({ required this.child, this.width = 1, this.height = 1, this.interactive = true, this.onTap, this.onSecondaryTap, this.onSecondaryTapDown, this.active = false, this.selected = false, this.empty = false, super.key, this.color, this.onTapDown, this.onTapUp});

  PanelGridTile.empty() : this(child: Container(), empty: true);

  factory PanelGridTile.idWithText({String? id, required String text, required Function() onTap}) {
    return PanelGridTile(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: HighContrastText(text, textAlign: TextAlign.center),
            ),
            if (id != null)
              Align(child: Text(id, style: TextStyle(fontSize: 12, color: Colors.white70)), alignment: Alignment.topLeft),
          ],
        ),
      ),
    );
  }

  factory PanelGridTile.media({ required Widget child, required String text, Function()? onTap}) {
    return PanelGridTile(
      onTap: onTap,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: child,
          ),
          Align(child: HighContrastText(text, textAlign: TextAlign.center), alignment: Alignment.bottomCenter),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapDown: onSecondaryTapDown,
      builder: (hovered) => Container(
        width: GRID_4_SIZE * width + ((width - 1) * 2),
        height: GRID_4_SIZE * height + ((height - 1) * 2),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: active
                ? Colors.deepOrange.shade700
                : (selected ? White : (interactive ? TileBorder : Colors.transparent)),
            width: 2,
          )),
          borderRadius: BorderRadius.circular(0),
          color: color ?? (empty ? Grey800 : (selected ? Grey500 : (hovered ? Grey600 : Grey700))),
        ),
        child: Stack(children: [
          if (active) Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: GRID_4_SIZE * width + ((width - 1) * 2),
              height: 2,
              color: Colors.deepOrange.shade700,
            ),
          ),
          child
        ]),
      ),
    );
  }
}

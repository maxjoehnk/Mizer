import 'package:flutter/material.dart';

import '../../consts.dart';

class NodeContainer extends StatelessWidget {
  final Widget? child;
  final bool selected;
  final bool selectedAdditionally;

  NodeContainer({this.child, this.selected = false, this.selectedAdditionally = false});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.move,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(OUTER_RADIUS)),
            side: _border,
          ),
          shadows: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(4, 4))
          ],
        ),
        child: Container(
          decoration: ShapeDecoration(
              color: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(INNER_RADIUS)),
              )),
          child: this.child,
        ),
      ),
    );
  }

  BorderSide get _border {
    if (selected) {
      return BorderSide(
        color: Colors.white,
        style: BorderStyle.solid,
        width: 2,
      );
    }
    if (selectedAdditionally) {
      return BorderSide(
        color: Colors.deepOrange,
        style: BorderStyle.solid,
        width: 2,
      );
    }

    return BorderSide(style: BorderStyle.none, width: 2);
  }
}

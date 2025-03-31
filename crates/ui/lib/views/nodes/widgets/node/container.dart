import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../../consts.dart';

class NodeContainer extends StatelessWidget {
  final Widget? child;
  final bool selected;
  final bool selectedAdditionally;
  final bool connected;
  final NodeDesigner designer;

  NodeContainer(
      {this.child,
      this.selected = false,
      this.selectedAdditionally = false,
      this.connected = false,
      required this.designer});

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
              color: designer.hasColor() ? DESIGNER_COLORS[designer.color] : Grey800,
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
        width: 4,
      );
    }
    if (selectedAdditionally) {
      return BorderSide(
        color: Colors.deepOrange,
        style: BorderStyle.solid,
        width: 4,
      );
    }
    if (connected) {
      return BorderSide(
        color: Colors.blueGrey,
        style: BorderStyle.solid,
        width: 4,
      );
    }

    return BorderSide(style: BorderStyle.none, width: 4);
  }
}

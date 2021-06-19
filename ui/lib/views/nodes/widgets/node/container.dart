import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../consts.dart';

class NodeContainer extends StatelessWidget {
  final Widget child;
  final bool selected;

  NodeContainer({this.child, this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(OUTER_RADIUS)),
          side: selected
              ? BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2,
                )
              : BorderSide(style: BorderStyle.none, width: 2),
        ),
        shadows: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(4, 4))
        ],
      ),
      child: Container(
        decoration: ShapeDecoration(
            color: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(INNER_RADIUS)),
            )),
        child: this.child,
      ),
    );
  }
}

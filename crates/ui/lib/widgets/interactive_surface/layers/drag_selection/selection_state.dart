import 'package:flutter/widgets.dart';
import 'package:mizer/i18n.dart';

class SelectionState {
  Offset start;
  Offset end;
  SelectionDirection? direction;

  SelectionState(Offset start)
      : this.start = start,
        this.end = start;

  void update(Offset localPosition) {
    this.end = localPosition;
    var offset = this.start - this.end;
    if (direction == null) {
      Axis primaryAxis = offset.dx.abs() > offset.dy.abs() ? Axis.horizontal : Axis.vertical;
      direction = SelectionDirection(primaryAxis);
    }
    direction!.update(offset);
  }
}

class SelectionDirection {
  Axis primaryAxis;
  AxisDirection vertical;
  AxisDirection horizontal;

  SelectionDirection(this.primaryAxis)
      : vertical = AxisDirection.up,
        horizontal = AxisDirection.right;

  update(Offset offset) {
    vertical = offset.dy > 0 ? AxisDirection.up : AxisDirection.down;
    horizontal = offset.dx > 0 ? AxisDirection.right : AxisDirection.left;
  }

  @override
  String toString() {
    String verticalName =
    vertical == AxisDirection.up ? "Bottom to Top".i18n : "Top to Bottom".i18n;
    String horizontalName =
    horizontal == AxisDirection.right ? "Right to Left".i18n : "Left to Right".i18n;

    return primaryAxis == Axis.vertical
        ? "$verticalName -> $horizontalName"
        : "$horizontalName -> $verticalName";
  }
}

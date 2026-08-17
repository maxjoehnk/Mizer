import 'package:fixnum/fixnum.dart';
import 'package:flutter/animation.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/layouts.pb.dart';

extension SizeExtensions on Size {
  ControlSize toControlSize() {
    return ControlSize(width: Int64(this.width.toInt()), height: Int64(this.height.toInt()));
  }

  Offset toLayoutGaps() {
    double width = (this.width.toDouble() / 10 - 1) * GRID_GAP_SIZE;
    double height = (this.height.toDouble() / 10 - 1) * GRID_GAP_SIZE;

    return Offset(width, height);
  }
}

extension PositionExtensions on Offset {
  ControlPosition toControlPosition() {
    return ControlPosition(x: Int64(this.dx.toInt()), y: Int64(this.dy.toInt()));
  }
}

extension ControlSizeExtensions on ControlSize {
  Size toScreen({ double multiplier = GRID_4_SIZE }) {
    return Size(this.width.toDouble(), this.height.toDouble()) / 10 * multiplier;
  }

  Offset toLayoutGaps() {
    double width = (this.width.toDouble() / 10 - 1) * GRID_GAP_SIZE;
    double height = (this.height.toDouble() / 10 - 1) * GRID_GAP_SIZE;

    return Offset(width, height);
  }
}

extension ControlPositionExtensions on ControlPosition {
  Offset toScreen({double multiplier = GRID_4_SIZE }) {
    return Offset(this.x.toDouble(), this.y.toDouble()) / 10 * multiplier;
  }
}

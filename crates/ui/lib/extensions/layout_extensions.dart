import 'package:fixnum/fixnum.dart';
import 'package:flutter/animation.dart';
import 'package:mizer/protos/layouts.pb.dart';

extension SizeExtensions on Size {
  ControlSize toControlSize() {
    return ControlSize(width: Int64(this.width.toInt()), height: Int64(this.height.toInt()));
  }
}

extension PositionExtensions on Offset {
  ControlPosition toControlPosition() {
    return ControlPosition(x: Int64(this.dx.toInt()), y: Int64(this.dy.toInt()));
  }
}

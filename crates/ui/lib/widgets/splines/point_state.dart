import 'dart:ui';

import 'spline_editor.dart';

abstract class PointState<T> {
  T data;
  bool hit = false;
  bool move = false;
  double x;
  double y;
  final double delta;

  PointState(this.data, this.x, this.y, this.delta);

  bool isHit(Offset position) {
    double x = position.dx;
    double y = position.dy;

    return hitTest(this.x, this.y, x, y, delta);
  }

  void update(T data);

  @override
  String toString() {
    return 'PointState{hit: $hit, move: $move, x: $x, y: $y}';
  }
}

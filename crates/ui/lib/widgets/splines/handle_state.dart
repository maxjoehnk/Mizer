import 'dart:ui';

import 'package:mizer/widgets/splines/spline_editor.dart';

abstract class HandleState<T> {
  T data;
  bool hit = false;
  bool move = false;
  double x;
  double y;
  bool first;
  final double delta;

  HandleState(this.data, this.x, this.y, this.first, this.delta);

  bool isHit(Offset position) {
    double x = position.dx;
    double y = position.dy;

    return hitTest(this.x, this.y, x, y, delta);
  }

  void update(T data);

  @override
  String toString() {
    return 'HandleState{hit: $hit, move: $move, x: $x, y: $y}';
  }
}

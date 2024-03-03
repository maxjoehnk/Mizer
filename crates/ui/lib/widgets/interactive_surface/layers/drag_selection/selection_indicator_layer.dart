import 'selection_state.dart';
import 'package:flutter/material.dart';

class SelectionIndicator extends StatelessWidget {
  final SelectionState state;

  const SelectionIndicator(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1000, 1000),
      foregroundPainter: DragPainter(state.start, state.end),
    );
  }
}

class DragPainter extends CustomPainter {
  Offset? start;
  Offset? end;

  DragPainter(this.start, this.end) : super();

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) {
      return;
    }
    Paint fill = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    Paint stroke = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var rect = RRect.fromRectAndRadius(Rect.fromPoints(start!, end!), Radius.circular(2));
    canvas.drawRRect(rect, fill);
    canvas.drawRRect(rect, stroke);
  }

  @override
  bool shouldRepaint(covariant DragPainter oldDelegate) {
    return oldDelegate.start != this.start || oldDelegate.end != this.end;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../consts.dart';

class CanvasBackgroundLayer extends StatelessWidget {
  final Widget? child;

  CanvasBackgroundLayer({this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(),
      child: this.child,
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white10;
    for (double i = 0; i < size.height; i += MULTIPLIER) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
    for (double i = 0; i < size.width; i += MULTIPLIER) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

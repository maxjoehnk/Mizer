import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';

class MovementPainter extends CustomPainter {
  final EffectChannel? pan;
  final EffectChannel? tilt;

  MovementPainter(this.pan, this.tilt);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1 * size.height, -1 * size.height);
    _drawAxis(canvas);
    _drawSecondaryAxis(canvas);
    if (pan != null && tilt != null) {
      _drawMovement(canvas);
    }
  }

  void _drawAxis(Canvas canvas) {
    Paint axisPaint = Paint()
      ..color = Color(0x55ffffff)
      ..style = PaintingStyle.stroke;
    var xAxis = Path()
      ..moveTo(0, 0.5)
      ..lineTo(1, 0.5);
    var yAxis = Path()
      ..moveTo(0.5, 0)
      ..lineTo(0.5, 1);
    canvas.drawPath(xAxis, axisPaint);
    canvas.drawPath(yAxis, axisPaint);
  }

  void _drawSecondaryAxis(Canvas canvas) {
    Paint axisPaint = Paint()
      ..color = Color(0x22ffffff)
      ..style = PaintingStyle.stroke;
    var axis = [
      Path()
        ..moveTo(0, 0.25)
        ..lineTo(1, 0.25),
      Path()
        ..moveTo(0, 0.75)
        ..lineTo(1, 0.75),
      Path()
        ..moveTo(0.25, 0)
        ..lineTo(0.25, 1),
      Path()
        ..moveTo(0.75, 0)
        ..lineTo(0.75, 1),
    ];
    axis.forEach((element) => canvas.drawPath(element, axisPaint));
  }

  void _drawMovement(Canvas canvas) {
    var pan = this.pan!;
    var tilt = this.tilt!;
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    var path = Path();
    for (var i = 0; i < pan.steps.length; i++) {
      var panStep = pan.steps[i];
      var tiltStep = tilt.steps[i];
      double x = panStep.value.direct;
      double y = tiltStep.value.direct;
      if (i == 0) {
        path.moveTo(x, y);
      }
      if (panStep.hasSimple()) {
        path.lineTo(x, y);
      } else if (panStep.hasCubic()) {
        double x1 = (panStep.cubic.c0a + tiltStep.cubic.c0a) / 2;
        double y1 = (panStep.cubic.c0b + tiltStep.cubic.c0b) / 2;
        double x2 = (panStep.cubic.c1a + tiltStep.cubic.c1a) / 2;
        double y2 = (panStep.cubic.c1b + tiltStep.cubic.c1b) / 2;
        path.cubicTo(x1, y1, x2, y2, x, y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

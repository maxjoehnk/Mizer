import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';

import 'frame_editor.dart';

class FramePainter extends CustomPainter {
  final EffectChannel channel;
  final List<PointState> points;
  final List<HandleState> handles;

  FramePainter(this.channel, this.points, this.handles);

  @override
  void paint(Canvas canvas, Size size) {
    _setupCanvas(canvas, size);
    var axisWidth = size.height;
    _drawAxis(canvas, axisWidth);
    _drawSecondaryAxis(canvas, axisWidth);
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = Color(0x11ffffff)
      ..style = PaintingStyle.fill;
    var upperLinePath = Path();
    var lowerLinePath = Path();
    var fillPath = Path();
    var backPath = [];
    var previousPoint = Offset(0, 0);
    for (var i = 0; i < channel.steps.length; i++) {
      var step = channel.steps[i];
      var offset = (i - 1).clamp(0, channel.steps.length);
      double x = i.toDouble();
      double y;
      double y2;
      if (step.value.hasRange()) {
        y = step.value.range.from;
        y2 = step.value.range.to;
      } else {
        y = step.value.direct;
        y2 = y;
      }
      if (i == 0) {
        upperLinePath.moveTo(x, y);
        lowerLinePath.moveTo(x, y2);
      }
      if (step.hasCubic()) {
        upperLinePath.cubicTo(
            offset + step.cubic.c0a, step.cubic.c0b, offset + step.cubic.c1a, step.cubic.c1b, x, y);
        lowerLinePath.cubicTo(offset + step.cubic.c0a, step.cubic.c0b, offset + step.cubic.c1a,
            step.cubic.c1b, x, y2);
        var handleIndex = (i - channel.steps.getRange(0, i).where((s) => !s.hasCubic()).length) * 2;
        handleIndex = handleIndex.clamp(0, this.handles.length - 2);
        _drawHandle(canvas, previousPoint.dx, previousPoint.dy, offset + step.cubic.c0a,
            step.cubic.c0b, this.handles[handleIndex + 1].hit);
        _drawHandle(
            canvas, x, y, offset + step.cubic.c1a, step.cubic.c1b, this.handles[handleIndex].hit);
      } else if (step.hasQuadratic()) {
        upperLinePath.quadraticBezierTo(step.quadratic.c0a, step.quadratic.c0b, x, y);
        lowerLinePath.quadraticBezierTo(step.quadratic.c0a, step.quadratic.c0b, x, y2);
      } else {
        upperLinePath.lineTo(x, y);
        lowerLinePath.lineTo(x, y2);
      }
      fillPath.lineTo(x, y);
      backPath.add([x, y2]);
      previousPoint = Offset(x, y);
    }
    for (var step in backPath.reversed) {
      fillPath.lineTo(step[0], step[1]);
    }
    canvas.drawPath(upperLinePath, linePaint);
    canvas.drawPath(lowerLinePath, linePaint);
    canvas.drawPath(fillPath, fillPaint);
    for (var point in points) {
      _drawPoint(canvas, point);
    }
  }

  void _setupCanvas(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1 * size.height, -1 * size.height);
  }

  @override
  bool shouldRepaint(covariant FramePainter oldDelegate) {
    return oldDelegate.channel != channel ||
        oldDelegate.points != this.points ||
        oldDelegate.handles != this.handles;
  }

  void _drawHandle(Canvas canvas, double x0, double y0, double x1, double y1, bool hit) {
    Paint pathPaint = Paint()
      ..color = Color(0xaaffffff)
      ..style = PaintingStyle.stroke;
    Paint handlePaint = Paint()
      ..color = hit ? Colors.red : Colors.white
      ..style = PaintingStyle.fill;
    var handle = Path()
      ..moveTo(x0, y0)
      ..lineTo(x1, y1);
    canvas.drawPath(handle, pathPaint);
    canvas.drawCircle(Offset(x1, y1), hit ? 0.03 : 0.02, handlePaint);
  }

  void _drawAxis(Canvas canvas, double width) {
    Paint axisPaint = Paint()
      ..color = Color(0x55ffffff)
      ..style = PaintingStyle.stroke;
    var xAxis = Path()
      ..moveTo(0, 0.0)
      ..lineTo(width, 0.0);
    var yAxis = Path()
      ..moveTo(0.0, 0)
      ..lineTo(0.0, 1);
    canvas.drawPath(xAxis, axisPaint);
    canvas.drawPath(yAxis, axisPaint);
  }

  void _drawSecondaryAxis(Canvas canvas, double width) {
    Paint axisPaint = Paint()
      ..color = Color(0x22ffffff)
      ..style = PaintingStyle.stroke;
    for (double i = 1; i < width; i++) {
      var path = Path()
        ..moveTo(i, 0)
        ..lineTo(i, 1);
      canvas.drawPath(path, axisPaint);
    }
  }

  void _drawPoint(Canvas canvas, PointState point) {
    Paint handlePaint = Paint()
      ..color = point.hit ? Colors.red : Colors.white
      ..style = PaintingStyle.fill;
    var x = point.x;
    var y = point.y;
    canvas.drawCircle(Offset(x, y), point.hit ? 0.03 : 0.02, handlePaint);
  }
}

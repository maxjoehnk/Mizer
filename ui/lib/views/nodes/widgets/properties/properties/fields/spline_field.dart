import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/widgets/splines/handle_state.dart';
import 'package:mizer/widgets/splines/point_state.dart';

const HANDLE_SIZE = 0.02;

class SplineFieldPainter<TData, TPoint extends PointState<TData>, THandle extends HandleState<TData>> extends CustomPainter {
  final List<TData> steps;
  final List<TPoint> points;
  final List<THandle> handles;

  SplineFieldPainter(this.steps, this.points, this.handles);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(size.height, -1 * size.height);
    _drawAxis(canvas);
    _drawSecondaryAxis(canvas);
    _drawMovement(canvas);
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
    canvas.drawRect(Rect.fromLTRB(0, 1, 1, 0), axisPaint);
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
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    var path = Path();
    var previousPoint = Offset(points.firstOrNull?.x ?? 0, points.firstOrNull?.y ?? 0);
    for (var i = 0; i < steps.length; i++) {
      var point = points[i];
      double x = point.x;
      double y = point.y;
      if (i == 0) {
        path.moveTo(x, y);
        path.lineTo(x, y);
      }else {
        var handleIndex = (i * 2).clamp(0, this.handles.length - 2);
        var handle1 = handles[handleIndex];
        var handle2 = handles[handleIndex + 1];
        path.cubicTo(handle1.x, handle1.y, handle2.x, handle2.y, x, y);
        _drawHandle(canvas, previousPoint.dx, previousPoint.dy, handle1.x, handle1.y, handle1.hit);
        _drawHandle(canvas, x, y, handle2.x, handle2.y, handle2.hit);
        previousPoint = Offset(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
    for (var point in points) {
      _drawPoint(canvas, point);
    }
  }

  void _drawHandle(Canvas canvas, double x0, double y0, double x1, double y1, bool hit) {
    Paint pathPaint = Paint()
      ..color = Color(0xaaffffff)
      ..style = PaintingStyle.stroke;
    Paint handlePaint = Paint()
      ..color = hit ? Colors.red : Colors.white54
      ..style = PaintingStyle.fill;
    var handle = Path()
      ..moveTo(x0, y0)
      ..lineTo(x1, y1);
    canvas.drawPath(handle, pathPaint);
    canvas.drawCircle(Offset(x1, y1), HANDLE_SIZE, handlePaint);
  }

  void _drawPoint(Canvas canvas, TPoint point) {
    Paint handlePaint = Paint()
      ..color = point.hit ? Colors.red : Colors.white
      ..style = PaintingStyle.fill;
    var x = point.x;
    var y = point.y;
    canvas.drawCircle(Offset(x, y), HANDLE_SIZE, handlePaint);
  }

  @override
  bool shouldRepaint(covariant SplineFieldPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.handles != handles;
  }
}

import 'package:flutter/material.dart';

class IntensityIndicator extends StatelessWidget {
  final Widget child;
  final double? value;

  const IntensityIndicator({super.key, required this.child, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) CustomPaint(size: Size.fromWidth(8), painter: FaderIndicatorPainter(value!)),
          Expanded(child: SizedBox(width: 2)),
          child,
        ]
    );
  }
}

class FaderIndicatorPainter extends CustomPainter {
  final double value;

  FaderIndicatorPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    var strokePaint = Paint()
      ..color = Colors.white54
      ..style = PaintingStyle.stroke;
    var backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    var fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 1, size.width, size.height - 1), backgroundPaint);
    canvas.drawRect(Rect.fromLTWH(0, 1, size.width, size.height - 1), strokePaint);
    canvas.drawRect(Rect.fromLTWH(0, size.height * (1 - value), size.width, size.height * value), fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


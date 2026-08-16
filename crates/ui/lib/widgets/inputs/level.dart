import 'package:flutter/material.dart';
import 'dart:math';

class LevelDisplay extends StatelessWidget {
  final Color? color;
  final double value;

  const LevelDisplay({super.key, this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _LevelPainter(value, color));
  }
}

class _LevelPainter extends CustomPainter {
  final double value;
  final Color? color;

  _LevelPainter(this.value, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()
      ..color = Colors.black;
    canvas.drawRect(Offset.zero & size, background);
    if (color != null) {
      Paint foreground = Paint()
        ..color = color!;
      double height = size.height * min(value, 1.0);
      canvas.drawRect(Rect.fromLTWH(0, size.height - height, size.width, height), foreground);
    }else {
      Paint foreground = Paint()
        ..color = Colors.green;
      double greenHeight = size.height * min(value, 0.6);
      canvas.drawRect(Rect.fromLTWH(0, size.height - greenHeight, size.width, greenHeight), foreground);
      if (value >= 0.6) {
        foreground = Paint()
          ..color = Colors.yellow;
        double yellowHeight = size.height * min(value, 0.3);
        canvas.drawRect(Rect.fromLTWH(0, size.height - greenHeight - yellowHeight, size.width, yellowHeight), foreground);
        if (value >= 0.9) {
          foreground = Paint()
            ..color = Colors.red;
          double redHeight = size.height * min(value, 0.1);
          canvas.drawRect(Rect.fromLTWH(0, size.height - greenHeight - yellowHeight - redHeight, size.width, redHeight), foreground);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LevelPainter oldDelegate) {
    return value != oldDelegate.value || color != oldDelegate.color;
  }
}

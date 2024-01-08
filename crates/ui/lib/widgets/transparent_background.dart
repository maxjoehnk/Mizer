import 'package:flutter/material.dart';

class TransparentBackground extends StatelessWidget {
  const TransparentBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TransparentBackgroundPainter(), size: Size.infinite);
  }
}

class TransparentBackgroundPainter extends CustomPainter {
  final double blockSize = 16;

  @override
  void paint(Canvas canvas, Size size) {
    for (var x = 0; x < size.width / blockSize; x++) {
      for (var y = 0; y < size.height / blockSize; y++) {
        if ((x + y) % 2 == 0) {
          canvas.drawRect(Rect.fromLTWH(x * blockSize, y * blockSize, blockSize, blockSize),
              Paint()..color = Colors.white30);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

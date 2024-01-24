import 'package:flutter/material.dart';

import '../consts.dart';

class TimecodeStrip extends StatelessWidget {
  const TimecodeStrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) =>
            CustomPaint(painter: TimecodeStripPainter(), size: constraints.biggest));
  }
}

class TimecodeStripPainter extends CustomPainter {
  final TextPainter textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint markerPaint = Paint()..color = Colors.white10;
    Paint significantMarkerPaint = Paint()..color = Colors.white30;
    for (int i = 0; i < size.width / pixelsPerSecond; i++) {
      double offset = i * pixelsPerSecond;
      if (i % 10 == 0) {
        canvas.drawLine(Offset(offset, 0), Offset(offset, size.height), significantMarkerPaint);
        TextPainter textPainter = TextPainter(text: buildTextSpan(i));
        textPainter.textDirection = TextDirection.ltr;
        textPainter.layout(maxWidth: size.width);
        textPainter.paint(canvas, Offset(offset + 4, 0));
      } else {
        canvas.drawLine(Offset(offset, size.height), Offset(offset, size.height - 10), markerPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

TextSpan buildTextSpan(int seconds) {
  return TextSpan(text: _formatTime(seconds));
}

String _formatTime(seconds) {
  int hours = seconds ~/ 3600;
  seconds -= hours * 3600;
  int minutes = seconds ~/ 60;
  seconds -= minutes * 60;

  return "${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}";
}

String _pad(int number) {
  return number.toString().padLeft(2, "0");
}

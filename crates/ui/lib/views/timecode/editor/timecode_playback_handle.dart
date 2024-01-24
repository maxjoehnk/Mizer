import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/plugin/ffi/api.dart';
import 'package:mizer/api/plugin/ffi/bindings.dart' as ffi;
import 'package:mizer/api/plugin/ffi/transport.dart';

import '../consts.dart';

class TimecodePlaybackIndicator extends StatefulWidget {
  final TimecodeReader? reader;

  const TimecodePlaybackIndicator({super.key, this.reader});

  @override
  State<TimecodePlaybackIndicator> createState() => _TimecodePlaybackIndicatorState();
}

class _TimecodePlaybackIndicatorState extends State<TimecodePlaybackIndicator> with SingleTickerProviderStateMixin {
  ffi.Timecode? timecode;
  late final Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) => setState(() => timecode = widget.reader?.readTimecode()));
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    widget.reader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TimecodePlaybackHandlePainter(timecode));
  }
}

class TimecodePlaybackHandlePainter extends CustomPainter {
  final ffi.Timecode? currentTimecode;

  TimecodePlaybackHandlePainter(this.currentTimecode);

  @override
  void paint(Canvas canvas, Size size) {
    if (currentTimecode == null) {
      return;
    }
    double x = firstColumnWidth + (currentTimecode!.totalSeconds * pixelsPerSecond);
    _drawLine(canvas, x, size);
    _drawHandle(x, canvas);
  }

  void _drawHandle(double x, Canvas canvas) {
    Path path = Path()
      ..moveTo(x, titleRowHeight)
      ..lineTo(x - 5, titleRowHeight - 8)
      ..lineTo(x + 5, titleRowHeight - 8)
      ..lineTo(x, titleRowHeight);
    Paint strokePaint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;
    Paint fillPaint = Paint()
      ..color = Colors.deepOrange.withOpacity(0.7);

    canvas.drawPath(path, strokePaint);
    canvas.drawPath(path, fillPaint);
  }

  void _drawLine(Canvas canvas, double x, Size size) {
    Paint paint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 2;
    canvas.drawLine(Offset(x, titleRowHeight), Offset(x, size.height), paint);
  }

  @override
  bool shouldRepaint(TimecodePlaybackHandlePainter oldDelegate) {
    return oldDelegate.currentTimecode != currentTimecode;
  }
}

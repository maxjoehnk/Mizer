import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/number_field.dart';

class ScaleIndicator extends StatefulWidget {
  final double scale;
  final double min;
  final double max;
  final Function(double)? onScaleChanged;

  const ScaleIndicator({super.key, required this.scale, required this.min, required this.max, required this.onScaleChanged});

  @override
  State<ScaleIndicator> createState() => _ScaleIndicatorState();
}

class _ScaleIndicatorState extends State<ScaleIndicator> {
  bool _interacting = false;
  Offset? _startPosition;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 10, child: GestureDetector(
        onTapUp: (e) {
          var scale = _getScale(context, e.localPosition);
          widget.onScaleChanged?.call(scale);
        },
        onHorizontalDragStart: (e) {
          setState(() {
            _interacting = true;
            _startPosition = e.localPosition;
          });
        },
        onHorizontalDragUpdate: (e) {
          if (_interacting) {
            double scale = _getScale(context, e.localPosition);
            widget.onScaleChanged?.call(scale);
          }
        },
        onHorizontalDragEnd: (e) {
          setState(() {
            _interacting = false;
            _startPosition = null;
          });
        },
        child: CustomPaint(painter: ScaleIndicatorPainter(scale: widget.scale.lerp(widget.min, widget.max)))));
  }

  double _getScale(BuildContext context, Offset position) {
    var scale = position.dx / context.size!.width;

    return scale.clamp(0.1, 1);
  }
}

class ScaleIndicatorPainter extends CustomPainter {
  final double scale;

  ScaleIndicatorPainter({super.repaint, required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.grey.shade800);
    var width = size.width * 0.1;
    var handle = Rect.fromLTWH(0, 0, width, size.height);
    var offset = Offset(((size.width - width) * scale - (width / 2)).clamp(0, size.width - width), 0);
    handle = handle.shift(offset);
    canvas.drawRect(handle, Paint()..color = Colors.grey.shade700);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), Paint()..color = Colors.grey.shade800);
  }

  @override
  bool shouldRepaint(covariant ScaleIndicatorPainter oldDelegate) {
    return oldDelegate.scale != scale;
  }
}

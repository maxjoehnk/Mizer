import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

const double GRID_SIZE = 50;

final Paint _gridPaint = Paint()
  ..style = PaintingStyle.stroke
  ..color = Colors.white10;

class CanvasBackgroundLayer extends StatelessWidget {
  const CanvasBackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(builder: (context, model, _) {
      return CustomPaint(painter: BackgroundPainter(model.transformationController.value), size: Size.infinite);
    });
  }
}

class BackgroundPainter extends CustomPainter {
  final Matrix4 transform;

  late final Vector3 translation;
  late final double scale;

  BackgroundPainter(this.transform) {
    translation = transform.getTranslation();
    scale = transform.getMaxScaleOnAxis();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.transform(transform.storage);
    var gridSize = GRID_SIZE;
    while ((gridSize * scale) < 10) {
      gridSize *= 5;
    }
    Size localSize = size / scale;
    var xBuffer = _getBuffer(translation.x, gridSize);
    var yBuffer = _getBuffer(translation.y, gridSize);
    for (double x = 0 - xBuffer; x < localSize.width - translation.x / scale; x += gridSize) {
      _drawLine(canvas, Offset(x, 0 - translation.y / scale), Offset(x, localSize.height - translation.y / scale));
    }
    for (double y = 0 - yBuffer; y < localSize.height - translation.y / scale; y += gridSize) {
      _drawLine(canvas, Offset(0 - translation.x / scale, y), Offset(localSize.width - translation.x / scale, y));
    }
  }

  double _getBuffer(double translation, double gridSize) {
    return ((translation / scale) / gridSize).roundToDouble() * gridSize;
  }

  void _drawLine(Canvas canvas, Offset start, Offset end) {
    canvas.drawLine(start, end, _gridPaint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.transform != transform;
  }
}

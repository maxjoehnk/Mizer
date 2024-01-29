import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../node_preview.dart';
import 'scale_indicator.dart';

class Minimap extends StatelessWidget {
  final TransformationController transformationController;

  const Minimap({super.key, required this.transformationController});

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
        builder: (context, model, _child)
    {
      var nodes = model.nodes.map((e) => e.node).toList();
      var scale = _getScale(transformationController.value);
      // var boundingBox = getBoundingBox(nodes);

      return Container(
        height: 150,
        width: 200,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(4)),
        foregroundDecoration: BoxDecoration(border: Border.all(color: Colors.grey.shade800, width: 2), borderRadius: BorderRadius.circular(4)),
        child: Stack(
          children: [
            SizedBox.expand(child: CustomPaint(painter: NodesPreviewPainter(nodes, model.channels))),
            // SizedBox.expand(child: TransformIndicator(scale: scale, translation: transformationController.value.getTranslation(), boundingBox: boundingBox)),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ScaleIndicator(scale: scale, min: MIN_ZOOM, max: MAX_ZOOM, onScaleChanged: (scale) {
                transformationController.value = Matrix4.identity()..scale(scale, scale);
              })
            )
          ],
        ),
      );
    });
  }

  Rect getBoundingBox(List<Node> nodes) {
    double minX = 0;
    double minY = 0;
    double maxX = 0;
    double maxY = 0;
    nodes.where((n) => !n.designer.hidden).forEach((node) {
      var left = node.designer.position.x;
      var right = left + NODE_PREVIEW_WIDTH;
      var top = node.designer.position.y;
      var bottom = top + NODE_PREVIEW_HEIGHT;
      minX = minX < left ? minX : left;
      minY = minY < top ? minY : top;
      maxX = maxX > right ? maxX : right;
      maxY = maxY > bottom ? maxY : bottom;
    });
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }
}

class TransformIndicator extends StatelessWidget {
  final double scale;
  final Vector3 translation;
  final Rect boundingBox;

  const TransformIndicator({super.key, required this.boundingBox, required this.scale, required this.translation});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TransformIndicatorPainter(scale: scale, translation: translation, boundingBox: boundingBox));
  }
}

class TransformIndicatorPainter extends CustomPainter {
  final double scale;
  final Vector3 translation;
  final Rect boundingBox;

  TransformIndicatorPainter({super.repaint, required this.scale, required this.translation, required this.boundingBox});

  @override
  void paint(Canvas canvas, Size size) {
    final minimapScale = _getMinimapScale(size, boundingBox);
    final minimapOffset = _getMinimapOffset(boundingBox, minimapScale);

    double inverseScale = (1 - scale);
    Size rectSize = Size(size.width, size.height) * inverseScale;
    Rect rect = Rect.fromLTWH(0, 0, rectSize.width, rectSize.height);
    var offset = Offset(translation.x, translation.y);
    offset = offset.scale(-1, -1);
    offset = offset.scale(minimapScale, minimapScale).translate(minimapOffset.dx, minimapOffset.dy);
    rect = rect.shift(offset);

    _drawIndicator(rect, canvas);
  }

  @override
  bool shouldRepaint(covariant TransformIndicatorPainter oldDelegate) {
    return oldDelegate.scale != scale || oldDelegate.translation != translation;
  }

  void _drawIndicator(Rect rect, Canvas canvas) {
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(4));
    Paint backgroundPaint = Paint()
      ..color = Colors.deepOrange.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    Paint borderPaint = Paint()
      ..color = Colors.deepOrange.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, backgroundPaint);
    canvas.drawRRect(rrect, borderPaint);
  }

  double _getMinimapScale(Size size, Rect boundingBox) {
    var scale = 1.0;
    if (boundingBox.width - size.width > boundingBox.height - size.height) {
      scale = boundingBox.width / size.width;
    } else {
      scale = boundingBox.height / size.height;
    }
    return scale;
  }

  Offset _getMinimapOffset(Rect boundingBox, double scale) {
    var offset = Offset.zero - boundingBox.topLeft;
    offset = offset / scale;

    return offset;
  }
}

double _getScale(Matrix4 matrix) {
  double scaleX = matrix.getColumn(0).xyz.length;

  return scaleX;
}


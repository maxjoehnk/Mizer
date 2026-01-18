import 'package:flutter/material.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/nodes/consts.dart';

const double NODE_PREVIEW_WIDTH = 4;
const double NODE_PREVIEW_HEIGHT = 2;

var i = 0;

class ContainerPreview extends StatelessWidget {
  final NodeModel node;

  const ContainerPreview({Key? key, required this.node})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(builder: (context, model, _child) {
      final List<Node> nodes = model.getContainerNodes(node);
      final List<NodeConnection> connections = model.getContainerConnections(node);

      return Container(
          height: 200,
          width: 300,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: CustomPaint(painter: NodesPreviewPainter(nodes, connections)));
    });
  }
}

class NodesPreviewPainter extends CustomPainter {
  final List<Node> nodes;
  final List<NodeConnection> connections;

  NodesPreviewPainter(this.nodes, this.connections);

  @override
  void paint(Canvas canvas, Size size) {
    var visibleNodes = nodes.where((n) => !n.designer.hidden).toList();

    if (visibleNodes.isEmpty) {
      return;
    }

    var boundingBox = _getBoundingBox(visibleNodes);
    double scale = _getScale(size, boundingBox);
    Offset offset = _getOffset(size, boundingBox, scale);

    _drawChannels(size, canvas, offset, scale);
    _drawNodes(size, canvas, offset, scale);
  }

  void _drawNodes(Size size, Canvas canvas, Offset offset, double scale) {
    nodes.where((n) => !n.designer.hidden).forEach((node) {
      var rect = Rect.fromLTWH(node.designer.position.x * scale, node.designer.position.y * scale,
          NODE_PREVIEW_WIDTH * scale, NODE_PREVIEW_HEIGHT * scale);
      rect = rect.shift(offset);

      final paint = Paint()
        ..color = CATEGORY_COLORS[node.details.category] ?? Colors.black
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(scale.clamp(1, 5))), paint);
    });
  }

  void _drawChannels(Size size, Canvas canvas, Offset offset, double scale) {
    connections.forEach((connection) {
      var startNode = nodes.firstWhere((node) => node.path == connection.sourceNode);
      var endNode = nodes.firstWhere((node) => node.path == connection.targetNode);
      var start = Offset(startNode.designer.position.x + NODE_PREVIEW_WIDTH / 2, startNode.designer.position.y + NODE_PREVIEW_HEIGHT / 2).scale(scale, scale).translate(offset.dx, offset.dy);
      var end = Offset(endNode.designer.position.x + NODE_PREVIEW_WIDTH / 2, endNode.designer.position.y + NODE_PREVIEW_HEIGHT / 2).scale(scale, scale).translate(offset.dx, offset.dy);
      final paint = Paint()
        ..color = getColorForProtocol(connection.protocol)
        ..strokeWidth = scale.clamp(1, 3) * 0.6
        ..style = PaintingStyle.stroke;
      Path path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(start.dx + 0.6 * (end.dx - start.dx), start.dy, end.dx + 0.6 * (start.dx - end.dx), end.dy,
            end.dx, end.dy);
      canvas.drawPath(path, paint);
    });
  }

  @override
  bool shouldRepaint(covariant NodesPreviewPainter oldDelegate) {
    return oldDelegate.nodes != nodes;
  }
}

Rect _getBoundingBox(List<Node> visibleNodes) {
  double minX = double.infinity;
  double minY = double.infinity;
  double maxX = double.negativeInfinity;
  double maxY = double.negativeInfinity;

  for (var node in visibleNodes) {
    var x = node.designer.position.x;
    var y = node.designer.position.y;
    minX = minX < x ? minX : x;
    minY = minY < y ? minY : y;
    maxX = maxX > x ? maxX : x;
    maxY = maxY > y ? maxY : y;
  }

  maxX += NODE_PREVIEW_WIDTH;
  maxY += NODE_PREVIEW_HEIGHT;

  return Rect.fromLTRB(minX, minY, maxX, maxY);
}

double _getScale(Size size, Rect boundingBox) {
  const double padding = 10.0;
  double scaleX = (size.width - padding * 2) / boundingBox.width;
  double scaleY = (size.height - padding * 2) / boundingBox.height;
  double scale = (scaleX < scaleY ? scaleX : scaleY).clamp(0, 10);
  return scale;
}

Offset _getOffset(Size size, Rect boundingBox, double scale) {
  double scaledWidth = boundingBox.width * scale;
  double scaledHeight = boundingBox.height * scale;
  double offsetX = (size.width - scaledWidth) / 2 - boundingBox.left * scale;
  double offsetY = (size.height - scaledHeight) / 2 - boundingBox.top * scale;

  return Offset(offsetX, offsetY);
}

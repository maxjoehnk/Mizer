import 'package:flutter/material.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/nodes/consts.dart';

const double NODE_PREVIEW_WIDTH = 10;
const double NODE_PREVIEW_HEIGHT = 5;

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
    final boundingBox = getBoundingBox().inflate(4);
    var scale = 1.0;
    if (boundingBox.width - size.width > boundingBox.height - size.height) {
      scale = boundingBox.width / size.width;
    } else {
      scale = boundingBox.height / size.height;
    }
    var offset = Offset.zero - boundingBox.topLeft;
    offset = offset / scale;
    _drawChannels(size, canvas, scale, offset);
    _drawNodes(size, canvas, scale, offset);
  }

  void _drawNodes(Size size, Canvas canvas, double scale, Offset offset) {
    nodes.where((n) => !n.designer.hidden).forEach((node) {
      var rect = Rect.fromLTWH(node.designer.position.x / scale, node.designer.position.y / scale,
          NODE_PREVIEW_WIDTH, NODE_PREVIEW_HEIGHT);
      rect = rect.shift(offset);
      final paint = Paint()
        ..color = CATEGORY_COLORS[node.details.category] ?? Colors.black
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(2)), paint);
    });
  }

  void _drawChannels(Size size, Canvas canvas, double scale, Offset offset) {
    connections.forEach((connection) {
      var startNode = nodes.firstWhere((node) => node.path == connection.sourceNode);
      var endNode = nodes.firstWhere((node) => node.path == connection.targetNode);
      var start = Offset(startNode.designer.position.x / scale + (NODE_PREVIEW_WIDTH / 2), startNode.designer.position.y / scale + (NODE_PREVIEW_HEIGHT / 2)) + offset;
      var end = Offset(endNode.designer.position.x / scale + (NODE_PREVIEW_WIDTH / 2), endNode.designer.position.y / scale + (NODE_PREVIEW_HEIGHT / 2)) + offset;
      final paint = Paint()
        ..color = getColorForProtocol(connection.protocol)
        ..strokeWidth = 1
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

  Rect getBoundingBox() {
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

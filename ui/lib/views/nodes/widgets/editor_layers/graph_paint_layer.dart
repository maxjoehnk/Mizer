import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/port_model.dart';

class GraphPaintLayer extends StatelessWidget {
  final NodeEditorModel model;

  GraphPaintLayer({ this.model });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: model.painterKey,
      child: SizedBox.expand(),
      painter: GraphLinePainter(model),
      willChange: true,
    );
  }
}

class GraphLinePainter extends CustomPainter {
  final NodeEditorModel model;

  GraphLinePainter(this.model);

  static Paint painter = Paint()
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    for (var channel in model.channels) {
      var fromPort = model.getPortModel(model.getNode(channel.sourceNode), channel.sourcePort, false);
      var toPort = model.getPortModel(model.getNode(channel.targetNode), channel.targetPort, true);
      if (fromPort == null || toPort == null) {
        continue;
      }
      Offset fromPosition = _getPosition(fromPort);
      Offset toPosition = _getPosition(toPort);
      draw(canvas, fromPosition, toPosition, channel);
    }
  }

  @override
  bool shouldRepaint(covariant GraphLinePainter oldDelegate) {
    return true;
  }

  Offset _getPosition(PortModel port) {
    return port.offset + Offset(port.size.width / 2, port.size.height / 2);
  }

  void draw(Canvas canvas, Offset from, Offset to, NodeConnection channel) {
    var paint = painter
      ..color = getColorForProtocol(channel.protocol).shade800;
    Path path = new Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(from.dx + 0.6 * (to.dx - from.dx), from.dy, to.dx + 0.6 * (from.dx - to.dx), to.dy, to.dx, to.dy);
    canvas.drawPath(path, paint);
  }
}

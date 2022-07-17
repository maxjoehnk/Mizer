import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';

class GraphPaintLayer extends StatelessWidget {
  final NodeEditorModel model;

  GraphPaintLayer({ required this.model });

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
      draw(canvas, fromPort.offset, toPort.offset, channel.protocol);
    }
    if (model.connecting != null) {
      var fromPort = model.getPortModel(model.connecting!.node, model.connecting!.port, false);
      if (fromPort == null) {
        return;
      }
      Offset fromPosition = fromPort.offset;
      Offset toPosition = model.connecting!.offset;
      draw(canvas, fromPosition, toPosition, model.connecting!.port.protocol, hit: model.connecting!.target != null);
    }
  }

  @override
  bool shouldRepaint(covariant GraphLinePainter oldDelegate) {
    return true;
  }

  void draw(Canvas canvas, Offset from, Offset to, ChannelProtocol protocol, { bool? hit }) {
    var paint = painter
      ..color = getColorForProtocol(protocol).shade800;
    if (hit == true) {
      paint.color = Colors.white;
    }
    Path path = new Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(from.dx + 0.6 * (to.dx - from.dx), from.dy, to.dx + 0.6 * (from.dx - to.dx), to.dy, to.dx, to.dy);
    canvas.drawPath(path, paint);
  }
}

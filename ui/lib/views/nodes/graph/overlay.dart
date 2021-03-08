
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../consts.dart';
import 'state.dart';

class GraphOverlay extends StatelessWidget {
  final RenderObject renderObject;

  GraphOverlay(this.renderObject);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(builder: (context, state) => CustomPaint(painter: GraphLinePainter(state, renderObject)));
  }
}

class GraphLinePainter extends CustomPainter {
  final GraphState state;
  final RenderObject renderObject;

  GraphLinePainter(this.state, this.renderObject);

  @override
  void paint(Canvas canvas, Size size) {
    if (renderObject == null) {
      return;
    }
    for (var channel in state.channels) {
      Offset fromPosition = _getFromPosition(channel);
      Offset toPosition = _getToPosition(channel);
      if (fromPosition == null || toPosition == null) {
        continue;
      }
      draw(canvas, fromPosition, toPosition);
    }
  }

  @override
  bool shouldRepaint(covariant GraphLinePainter oldDelegate) {
    return oldDelegate.state != this.state;
  }

  Offset _getFromPosition(NodeConnection channel) {
    String identifier = getIdentifierForChannelFrom(channel);
    GraphPortKey key = state.outputs[identifier];
    Offset position = _getPosition(key);

    return position;
  }

  Offset _getToPosition(NodeConnection channel) {
    String identifier = getIdentifierForChannelTo(channel);
    GraphPortKey key = state.inputs[identifier];
    Offset position = _getPosition(key);

    return position;
  }

  Offset _getPosition(GraphPortKey key) {
    double offset = DOT_SIZE / 2;
    RenderBox renderBox = key.currentContext?.findRenderObject();
    Offset position = renderBox?.localToGlobal(Offset(offset, offset), ancestor: renderObject);

    return position;
  }

  void draw(Canvas canvas, Offset from, Offset to) {
    Paint paint = _getPaint();
    if ((to.dy - from.dy).abs() < 20) {
      _drawLine(canvas, from, to, paint);
    }else {
      _drawBezier(from, to, canvas, paint);
    }

  }

  Paint _getPaint() {
    var paint = Paint()..color = Colors.purple ..strokeWidth = 2..style= PaintingStyle.stroke;
    return paint;
  }

  void _drawBezier(Offset from, Offset to, Canvas canvas, Paint paint) {
    Path path = new Path();
    path.moveTo(from.dx, from.dy);
    path.cubicTo(from.dx + 20, from.dy + 20, to.dx - 20, to.dy - 20, to.dx, to.dy);
    canvas.drawPath(path, paint);
  }

  void _drawLine(Canvas canvas, Offset from, Offset to, Paint paint) {
    canvas.drawLine(from, to, paint);
  }
}

import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';

class GraphEngine extends StatelessWidget {
  final Nodes nodes;
  final Widget child;

  GraphEngine({ this.nodes, this.child });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => GraphBloc(nodes), child: GraphEngineInternal(this.child, this.nodes));
  }
}

class GraphEngineInternal extends StatefulWidget {
  final Nodes nodes;
  final Widget child;

  GraphEngineInternal(this.child, this.nodes);

  @override
  _GraphEngineInternalState createState() => _GraphEngineInternalState();
}

class _GraphEngineInternalState extends State<GraphEngineInternal> {
  GlobalKey _widgetKey = GlobalKey();
  RenderObject renderObject;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  Widget build(BuildContext context) {
    context.read<GraphBloc>().update(widget.nodes);
    return Stack(children: [
      GraphOverlay(renderObject),
      this.widget.child,
    ], key: _widgetKey);
  }

  void _afterLayout(_) {
    log("afterLayout");
    setState(() {
      this.renderObject = _widgetKey.currentContext.findRenderObject();
    });
  }
}

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

  GraphLinePainter(this.state, this.renderObject) {
    log("renderObject: $renderObject");
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (renderObject == null) {
      return;
    }
    for (var channel in state.channels) {
      Offset fromPosition = _getFromPosition(channel);
      Offset toPosition = _getToPosition(channel);
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
    RenderBox renderBox = key.currentContext.findRenderObject();
    Offset position = renderBox.localToGlobal(Offset(4, 4), ancestor: renderObject);

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

class GraphState {
  HashMap<String, GraphPortKey> inputs;
  HashMap<String, GraphPortKey> outputs;
  List<NodeConnection> channels;

  GraphState(Nodes nodes) {
    this.inputs = HashMap();
    this.outputs = HashMap();
    this.channels = nodes.channels;
    for (var node in nodes.nodes) {
      for (var port in node.inputs) {
        var identifier = getNodePortIdentifier(node.path, port.name, true);
        inputs[identifier] = GraphPortKey(identifier);
      }
      for (var port in node.outputs) {
        var identifier = getNodePortIdentifier(node.path, port.name, false);
        outputs[identifier] = GraphPortKey(identifier);
      }
    }
  }

  GraphPortKey getKey(Node node, Port port, bool input) {
    var identifier = getNodePortIdentifier(node.path, port.name, input);
    if (input) {
      return this.inputs[identifier];
    }else {
      return this.outputs[identifier];
    }
  }

  @override
  String toString() {
    return "inputs: $inputs, outputs: $outputs";
  }
}

class GraphPortKey extends LabeledGlobalKey {
  final String identifier;

  GraphPortKey(this.identifier): super(identifier);
}

String getIdentifierForChannelFrom(NodeConnection connection) {
  return getNodePortIdentifier(connection.sourceNode, connection.sourcePort.name, false);
}

String getIdentifierForChannelTo(NodeConnection connection) {
  return getNodePortIdentifier(connection.targetNode, connection.targetPort.name, true);
}

String getNodePortIdentifier(String path, String port, bool input) {
  return "$port${input ? '>' : '<'}$path";
}

class GraphBloc extends Cubit<GraphState> {
  Nodes nodes;

  GraphBloc(this.nodes): super(GraphState(nodes));

  void update(Nodes nodes) {
    this.nodes = nodes;
    this.emit(GraphState(nodes));
  }
}

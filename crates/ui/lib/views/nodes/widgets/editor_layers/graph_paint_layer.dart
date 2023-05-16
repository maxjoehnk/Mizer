import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';

class GraphPaintLayer extends StatefulWidget {
  final NodeEditorModel model;

  GraphPaintLayer({required this.model});

  @override
  State<GraphPaintLayer> createState() => _GraphPaintLayerState();
}

class _GraphPaintLayerState extends State<GraphPaintLayer> with TickerProviderStateMixin {
  int pulseWidth = 2;
  late AnimationController _animationController;
  late Animation _animation;
  NodesPointer? _pointer;
  List<NodePortMetadata> _metadata = [];
  Ticker? _metadataTicker;

  @override
  void initState() {
    super.initState();
    var nodesApi = context.read<NodesApi>();
    nodesApi.getNodesPointer().then((pointer) {
      _pointer = pointer;
      _metadataTicker = this.createTicker((elapsed) {
        setState(() {
          _metadata = pointer.readPortMetadata();
        });
      });
      _metadataTicker!.start();
    });
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn);
    _animationController.repeat(reverse: true);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pointer?.dispose();
    _metadataTicker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: widget.model.painterKey,
      child: SizedBox.expand(),
      painter: GraphLinePainter(widget.model, _metadata, ((_animation.value + 1) * 2)),
      willChange: true,
    );
  }
}

class GraphLinePainter extends CustomPainter {
  final NodeEditorModel model;
  final List<NodePortMetadata> portMetadata;
  final double activeWidth;

  GraphLinePainter(this.model, this.portMetadata, this.activeWidth);

  static Paint painter = Paint()
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  Paint activePainter = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    activePainter.strokeWidth = activeWidth;

    for (var channel in model.channels) {
      var fromNode = model.getNode(channel.sourceNode);
      var toNode = model.getNode(channel.targetNode);
      if (fromNode == null || toNode == null) {
        print("missing node $channel $fromNode $toNode");
        continue;
      }
      var fromPort = model.getPortModel(fromNode, channel.sourcePort, false);
      var toPort = model.getPortModel(toNode, channel.targetPort, true);
      if (fromPort == null || toPort == null) {
        continue;
      }
      bool active = portMetadata
              .firstWhereOrNull((element) =>
                  element.path == channel.sourceNode && element.port == channel.sourcePort.name)
              ?.pushedValue ??
          false;

      drawConnection(canvas, fromPort.offset, toPort.offset, channel.protocol,
          active: active, highlight: _isHighlighted(channel));
    }
    if (model.connecting != null) {
      var fromPort = model.getPortModel(model.connecting!.node, model.connecting!.port, false);
      if (fromPort == null) {
        return;
      }
      Offset fromPosition = fromPort.offset;
      Offset toPosition = model.connecting!.offset;
      drawConnection(canvas, fromPosition, toPosition, model.connecting!.port.protocol,
          hit: model.connecting!.target != null, active: false);
    }
  }

  @override
  bool shouldRepaint(covariant GraphLinePainter oldDelegate) {
    return true;
  }

  void drawConnection(Canvas canvas, Offset from, Offset to, ChannelProtocol protocol,
      {bool hit = false, bool active = true, bool highlight = false}) {
    var paint = active ? activePainter : painter;
    paint.color = hit ? Colors.white : getColorForProtocol(protocol).shade800;
    if (highlight) {
      paint.color = Colors.blueGrey;
    }
    Path path = new Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(from.dx + 0.6 * (to.dx - from.dx), from.dy, to.dx + 0.6 * (from.dx - to.dx), to.dy,
          to.dx, to.dy);
    canvas.drawPath(path, paint);
  }

  bool _isHighlighted(NodeConnection channel) {
    var sourceNode = model.nodes.firstWhereOrNull((n) => n.node.path == channel.sourceNode);
    var targetNode = model.nodes.firstWhereOrNull((n) => n.node.path == channel.targetNode);

    return (model.connectedToSelectedNodes.contains(sourceNode) &&
            model.selectedNode == targetNode) ||
        (model.connectedToSelectedNodes.contains(targetNode) && model.selectedNode == sourceNode);
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/node/base_node.dart';

import 'node_selection.dart';

class FetchNodesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NodesBloc>().add(FetchNodes());
    return BlocBuilder<NodesBloc, Nodes>(builder: (context, nodes) {
      return NodesView(nodes);
    });
  }
}

class NodesView extends StatelessWidget {
  final Nodes nodes;

  NodesView(this.nodes);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        constrained: true,
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.001,
        maxScale: 10,
        child: NodesViewer(this.nodes));
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 0; i < size.height; i += MULTIPLIER) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), Paint()..color = Colors.white10);
    }
    for (double i = 0; i < size.width; i += MULTIPLIER) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), Paint()..color = Colors.white10);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class NodesViewer extends StatefulWidget {
  final Nodes nodes;

  NodesViewer(this.nodes);

  @override
  _NodesViewerState createState() => _NodesViewerState();
}

class _NodesViewerState extends State<NodesViewer> {
  Node selectedNode;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(),
      child: Padding(
        padding: const EdgeInsets.all(MULTIPLIER),
        child: NodeSelectionContainer(
          child: CustomMultiChildLayout(
              delegate: NodesLayoutDelegate(this.widget.nodes),
              children: this
                  .widget
                  .nodes
                  .nodes
                  .map((node) => LayoutId(
                      id: node.path,
                      child: BaseNode.fromNode(
                        node,
                        onSelect: () => setState(() => selectedNode = node),
                        selected: node == selectedNode,
                      )))
                  .toList()),
          onSelectNewNode: (nodeType, position) {
            log("adding new node with type $nodeType at ${position / MULTIPLIER}");
            context.read<NodesBloc>().add(AddNode(nodeType: nodeType, position: position / MULTIPLIER));
          },
        ),
      ),
    );
  }
}

const double MULTIPLIER = 75;

class NodesLayoutDelegate extends MultiChildLayoutDelegate {
  final Nodes nodes;

  NodesLayoutDelegate(this.nodes);

  @override
  void performLayout(Size size) {
    for (var node in this.nodes.nodes) {
      layoutChild(node.path, BoxConstraints.loose(size));
      var offset = Offset(node.designer.position.x * MULTIPLIER, node.designer.position.y * MULTIPLIER);
      positionChild(node.path, offset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

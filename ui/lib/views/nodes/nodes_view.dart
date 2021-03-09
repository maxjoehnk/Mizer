import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';

import 'background.dart';
import 'canvas.dart';
import 'consts.dart';
import 'graph/engine.dart';
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

class NodesView extends StatefulWidget {
  final Nodes nodes;

  NodesView(this.nodes);

  @override
  _NodesViewState createState() => _NodesViewState();
}

class _NodesViewState extends State<NodesView> {
  final TransformationController controller = TransformationController(
      Matrix4.translationValues(
          (CANVAS_SIZE / 2) * -1, (CANVAS_SIZE / 2) * -1, 0));

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        transformationController: controller,
        constrained: false,
        boundaryMargin: EdgeInsets.all(0),
        minScale: 0.001,
        maxScale: 10,
        child: Container(
            width: CANVAS_SIZE,
            height: CANVAS_SIZE,
            child: OverflowBox(
                child: GraphEngine(
                    nodes: this.widget.nodes,
                    child: NodesViewer(this.widget.nodes)))));
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
    return NodeSelectionContainer(
      child: NodeCanvasBackground(
        child: Padding(
          padding: const EdgeInsets.all(MULTIPLIER),
          child: NodeCanvas(nodes: this.widget.nodes),
        ),
      ),
      onSelectNewNode: (nodeType, position) {
        double canvasCenter = CANVAS_SIZE / 2;
        // TODO: translate by parent position
        Offset offset = Offset(position.dx - canvasCenter, position.dy - canvasCenter) / MULTIPLIER;
        log("adding new node with type $nodeType at $offset");
        context
            .read<NodesBloc>()
            .add(AddNode(nodeType: nodeType, position: offset));
      },
    );
  }
}

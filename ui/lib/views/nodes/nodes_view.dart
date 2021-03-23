import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';

import 'background.dart';
import 'canvas.dart';
import 'consts.dart';
import 'graph/engine.dart';
import 'node_properties.dart';
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
      Matrix4.translationValues((CANVAS_SIZE / 2) * -1, (CANVAS_SIZE / 2) * -1, 0));

  Node selectedNode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
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
                        child: NodesViewer(
                          nodes: this.widget.nodes,
                          selectedNodes: this.selectedNode == null ? [] : [this.selectedNode],
                          onSelect: (node) => setState(() {
                            this.selectedNode = node;
                          }),
                        ))))),
        NodePropertiesPane(node: this.selectedNode),
      ],
    );
  }
}

class NodesViewer extends StatelessWidget {
  final Nodes nodes;
  final Function(Node) onSelect;
  final List<Node> selectedNodes;

  NodesViewer({this.nodes, this.onSelect, this.selectedNodes});

  @override
  Widget build(BuildContext context) {
    return NodeSelectionContainer(
      child: NodeCanvasBackground(
        child: Padding(
          padding: const EdgeInsets.all(MULTIPLIER),
          child: NodeCanvas(
              nodes: this.nodes, onSelect: this.onSelect, selectedNodes: this.selectedNodes),
        ),
      ),
      onSelectNewNode: (nodeType, position) {
        double canvasCenter = CANVAS_SIZE / 2;
        // TODO: translate by parent position
        Offset offset = Offset(position.dx - canvasCenter, position.dy - canvasCenter) / MULTIPLIER;
        log("adding new node with type $nodeType at $offset");
        context.read<NodesBloc>().add(AddNode(nodeType: nodeType, position: offset));
      },
    );
  }
}

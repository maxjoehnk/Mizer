import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/GraphView.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart' as api;
import 'package:mizer/views/nodes/node/base_node.dart';

class FetchNodesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesBloc, api.Nodes>(builder: (context, nodes) {
      return DebugNodesView(nodes);
      // return NodesView(nodes);
    });
  }
}

class DebugNodesView extends StatelessWidget {
  final api.Nodes nodes;

  DebugNodesView(this.nodes);

  @override
  Widget build(BuildContext context) {
    return ListView(children: this.nodes.nodes.map((node) => BaseNode.fromNode(node)).toList());
  }
}

class NodesView extends StatelessWidget {
  final Graph _graph = Graph();

  NodesView(api.Nodes nodes) {
    Map<String, Node> graphNodes = Map();
    for (var value in nodes.nodes) {
      log("node ${value.title} ${value.type}");
      final Node node = Node(BaseNode.fromNode(value));
      _graph.addNode(node);
      graphNodes[value.id] = node;
    }
    // for (var channel in nodes.channels) {
    //   var lhs = graphNodes[channel.outputNode];
    //   var rhs = graphNodes[channel.inputNode];
    //
    //   log("lhs: $lhs, rhs: $rhs");
    //
    //   _graph.addEdge(lhs, rhs);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: true,
      boundaryMargin: EdgeInsets.all(100),
      minScale: 0.01,
      maxScale: 5.6,
      child: GraphView(
        graph: _graph,
        algorithm: FruchtermanReingoldAlgorithm(),
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke
      )
    );
  }
}

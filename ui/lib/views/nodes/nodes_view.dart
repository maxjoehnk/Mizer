import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart' as api;
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/node/base_node.dart';

import 'node_selection.dart';

class FetchNodesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesBloc, api.Nodes>(builder: (context, nodes) {
      // return DebugNodesView(nodes);
      return NodesView(nodes);
    });
  }
}

class DebugNodesView extends StatelessWidget {
  final api.Nodes nodes;

  DebugNodesView(this.nodes);

  @override
  Widget build(BuildContext context) {
    return NodeSelectionContainer(
      child: ListView(
          children:
              this.nodes.nodes.map((node) => BaseNode.fromNode(node)).toList()),
      onSelection: (nodeType) {
        log("adding new node with type $nodeType");
      },
    );
  }
}

class NodesView extends StatelessWidget {
  final api.Nodes nodes;

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

class NodesViewer extends StatelessWidget {
  final api.Nodes nodes;

  NodesViewer(this.nodes);

  @override
  Widget build(BuildContext context) {
    return NodeSelectionContainer(
      child: CustomMultiChildLayout(
          delegate: NodesLayoutDelegate(this.nodes),
          children: this.nodes.nodes.map((node) => LayoutId(id: node.id, child: BaseNode.fromNode(node))).toList()),
      onSelection: (nodeType) {
        log("adding new node with type $nodeType");
      },
    );
  }
}

const MULTIPLIER = 75;

class NodesLayoutDelegate extends MultiChildLayoutDelegate {
  final api.Nodes nodes;

  NodesLayoutDelegate(this.nodes);

  @override
  void performLayout(Size size) {
    for (var node in this.nodes.nodes) {
      layoutChild(node.id, BoxConstraints.loose(size));
      var offset = Offset(node.designer.x * MULTIPLIER, node.designer.y * MULTIPLIER);
      positionChild(node.id, offset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

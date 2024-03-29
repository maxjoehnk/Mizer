import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:provider/provider.dart';

import '../../models/node_editor_model.dart';
import '../../models/node_model.dart';
import 'base_node.dart';

class NodeControl extends StatefulWidget {
  final NodeModel nodeModel;
  final bool collapsed;

  NodeControl(this.nodeModel, {this.collapsed = false});

  @override
  _NodeControlState createState() => _NodeControlState();
}

class _NodeControlState extends State<NodeControl> {
  Widget? node;

  @override
  void initState() {
    super.initState();
    node = _buildNode();
  }

  @override
  Widget build(BuildContext context) {
    var nodesApi = context.read<NodesApi>();
    var node = _buildNode();
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) => Draggable<NodeModel>(
        data: widget.nodeModel,
        child: node,
        childWhenDragging: Container(),
        feedback: RepositoryProvider<NodesApi>.value(
          value: nodesApi,
          child: ChangeNotifierProvider<NodeEditorModel>.value(
              value: model,
              builder: (context, child) {
                return Transform.scale(
                  scale: model.transformationController.value.getMaxScaleOnAxis(),
                  child: node,
                );
              }),
        ),
      ),
    );
  }

  Widget _buildNode() {
    return Consumer<NodeEditorModel>(builder: (context, model, _) {
      return BaseNode.fromNode(widget.nodeModel,
          key: widget.nodeModel.key,
          selected: model.selectedNode == widget.nodeModel,
          selectedAdditionally: model.otherSelectedNodes.contains(widget.nodeModel),
          connected: model.connectedToSelectedNodes.contains(widget.nodeModel),
          collapsed: widget.collapsed,
          onSelect: () => model.selectNode(widget.nodeModel),
          onSelectAdditional: () => model.selectAdditionalNodes([widget.nodeModel]));
    });
  }
}

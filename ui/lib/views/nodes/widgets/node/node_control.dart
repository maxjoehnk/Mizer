import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/preview_handler.dart';
import 'package:provider/provider.dart';

import '../../models/node_editor_model.dart';
import '../../models/node_model.dart';
import 'base_node.dart';

class NodeControl extends StatefulWidget {
  final NodeModel nodeModel;

  NodeControl(this.nodeModel);

  @override
  _NodeControlState createState() => _NodeControlState();
}

class _NodeControlState extends State<NodeControl> {
  Widget node;

  @override
  void initState() {
    super.initState();
    node = _buildNode();
  }

  @override
  Widget build(BuildContext context) {
    var handler = context.read<PreviewHandler>();
    var node = _buildNode();
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) => Draggable(
        data: widget.nodeModel,
        child: node,
        childWhenDragging: Container(),
        feedback: RepositoryProvider<PreviewHandler>.value(
          value: handler,
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
      return BaseNode.fromNode(widget.nodeModel.node,
          key: widget.nodeModel.key, selected: model.selectedNode == widget.nodeModel, onSelect: () => model.selectNode(widget.nodeModel));
    });
  }
}


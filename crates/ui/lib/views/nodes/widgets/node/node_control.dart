import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/base_node.dart';

class NodeControl extends StatefulWidget {
  final NodeModel nodeModel;
  final bool collapsed;

  NodeControl(this.nodeModel, {this.collapsed = false});

  @override
  _NodeControlState createState() => _NodeControlState();
}

class _NodeControlState extends State<NodeControl> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(builder: (context, model, _) {
      return BaseNode.fromNode(widget.nodeModel,
          key: widget.nodeModel.key,
          selected: model.selectedNode?.node.path == widget.nodeModel.node.path,
          selectedAdditionally: model.otherSelectedNodes.any((nodeModel) => nodeModel.node.path == widget.nodeModel.node.path),
          connected: model.connectedToSelectedNodes.any((nodeModel) => nodeModel.node.path == widget.nodeModel.node.path),
          collapsed: widget.collapsed,
          onSelect: () => model.selectNode(widget.nodeModel),
          onSelectAdditional: () => model.selectAdditionalNode(widget.nodeModel));
    });
  }
}

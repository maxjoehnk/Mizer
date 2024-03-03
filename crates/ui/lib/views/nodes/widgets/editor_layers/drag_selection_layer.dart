import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/widgets/interactive_surface/interactive_surface.dart';
import 'package:provider/provider.dart';

class NodesDragSelectionLayer extends DragSelectionLayer {
  final List<NodeModel> nodes;

  NodesDragSelectionLayer({required this.nodes, required super.transformation, required super.selectionState, required super.onUpdateSelection});

  @override
  void onSelection(BuildContext context, Rect rect) {
    List<NodeModel> selection = this
        .nodes
        .where((node) => node.rect.overlaps(rect))
        .toList();

    NodeEditorModel model = context.read();
    model.selectAdditionalNodes(selection);
  }

  @override
  bool shouldIgnore(Offset position) {
    return this.nodes.any((node) => node.rect.contains(position));
  }
}

import 'package:flutter/widgets.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';

import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/widgets/node/node_control.dart';

class NodesTarget extends StatefulWidget {
  @override
  State<NodesTarget> createState() => _NodesTargetState();
}

class _NodesTargetState extends State<NodesTarget> {
  Offset? startOffset;
  Offset? currentOffset;

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(builder: (context, model, _) {
      return SizedBox.expand(
          child: Stack(
        clipBehavior: Clip.none,
        children: model.nodes.where((node) => !node.node.designer.hidden).map((node) {
          var offset = node.offset;
          if (currentOffset != null) {
            if (model.selectedNode != null && model.selectedNode!.node.path == node.node.path ||
                model.otherSelectedNodes.any((element) => element.node.path == node.node.path)) {
              offset += currentOffset!;
            }
          }

          return Transform(
            transform: model.transformationController.value *
                Matrix4.translation(Vector3(offset.dx, offset.dy, 0)),
            child: GestureDetector(
                onPanStart: (e) {
                  setState(() {
                      startOffset = e.localPosition;
                      currentOffset = Offset.zero;
                    });
                  if (model.isSelected(node.node.path)) {
                    return;
                  }
                  model.selectNode(node);
                },
                onPanUpdate: (e) {
                  if (startOffset == null) {
                    return;
                  }
                  setState(() {
                    currentOffset = e.localPosition - startOffset!;
                  });
                  model.updateMovement();
                },
                onPanEnd: (e) {
                  NodesBloc bloc = context.read();
                  List<MoveNode> movements = [];
                  if (model.selectedNode != null) {
                    model.selectedNode!.offset += currentOffset!;
                    movements.add(MoveNode(model.selectedNode!.node.path, model.selectedNode!.getPosition()));
                  }
                  for (var selectedNode in model.otherSelectedNodes) {
                    if (selectedNode.node.path == model.selectedNode?.node.path) {
                      continue;
                    }
                    var node = model.nodes.firstWhere((element) => element.node.path == selectedNode.node.path);
                    node.offset += currentOffset!;
                    movements.add(MoveNode(selectedNode.node.path, node.getPosition()));
                  }
                  bloc.add(MoveNodes(movements));
                  model.update();
                  setState(() {
                    startOffset = null;
                    currentOffset = null;
                  });
                },
                child: NodeControl(node)),
          );
        }).toList(),
      ));
    });
  }
}

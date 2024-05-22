import 'package:flutter/widgets.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:provider/provider.dart';

import '../../models/node_editor_model.dart';

class CanvasDropLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(
      builder: (context, model, _) {
        return DragTarget(
          builder: (context, candidates, rejects) {
            return SizedBox.expand();
          },
          onWillAcceptWithDetails: (details) => details.data is NodeModel,
          onAcceptWithDetails: (DragTargetDetails<NodeModel> details) {
            RenderBox canvasBox = context.findRenderObject() as RenderBox;
            RenderBox elementBox = details.data.key.currentContext!.findRenderObject() as RenderBox;
            Offset off = model.transformationController.toScene(
              canvasBox.globalToLocal(
                elementBox.localToGlobal(Offset.zero),
              ),
            );
            details.data.offset = off;
            NodesBloc bloc = context.read();
            if (details.data.node.designer.hidden) {
              bloc.add(ShowNode(details.data.node.path, details.data.getPosition(), model.parent?.node.path));
            }
          },
          onMove: (_) {
            model.updateNodes();
            model.update();
          },
        );
      },
    );
  }
}

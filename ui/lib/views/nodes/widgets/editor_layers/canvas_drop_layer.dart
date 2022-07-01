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
          onWillAccept: (data) => data is NodeModel,
          onAccept: (NodeModel data) {
            RenderBox canvasBox = context.findRenderObject() as RenderBox;
            RenderBox elementBox = data.key.currentContext!.findRenderObject() as RenderBox;
            Offset off = model.transformationController.toScene(
              canvasBox.globalToLocal(
                elementBox.localToGlobal(Offset.zero),
              ),
            );
            data.offset = off;
            NodesBloc bloc = context.read();
            if (data.node.designer.hidden) {
              bloc.add(ShowNode(data.node.path, data.getPosition(), model.parent?.node.path));
            }else {
              model.updateNodes();
              model.update();
              bloc.add(MoveNode(data.node.path, data.getPosition()));
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

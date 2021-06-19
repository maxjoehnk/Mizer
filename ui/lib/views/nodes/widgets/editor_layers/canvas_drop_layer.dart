import 'package:flutter/widgets.dart';
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
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            RenderBox canvasBox = context.findRenderObject();
            RenderBox elementBox = data.key.currentContext.findRenderObject();
            Offset off = model.transformationController.toScene(
              canvasBox.globalToLocal(
                elementBox.localToGlobal(Offset.zero),
              ),
            );
            data.offset = off;
            model.updateNodes();
            model.update();
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

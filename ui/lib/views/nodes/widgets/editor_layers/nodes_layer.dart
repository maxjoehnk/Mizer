import 'package:flutter/widgets.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';

import '../../models/node_editor_model.dart';
import '../node/node_control.dart';

class NodesTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(builder: (context, model, _) {
      return DragTarget<Node>(
          builder: (context, candidates, rejects) {
            return SizedBox.expand(
                child: Stack(
              clipBehavior: Clip.none,
              children: model.nodes
                  .map((node) => Transform(
                        transform: model.transformationController.value *
                            Matrix4.translation(Vector3(node.offset.dx, node.offset.dy, 0)),
                        child: NodeControl(node),
                      ))
                  .toList(),
            ));
          },
          onWillAccept: (data) => false,
          onMove: (details) {
            model.updateNodes();
            model.update();
          });
    });
  }
}

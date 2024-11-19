import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

import '../../models/node_editor_model.dart';

class CommentsTarget extends StatefulWidget {
  @override
  State<CommentsTarget> createState() => _CommentsTargetState();
}

class _CommentsTargetState extends State<CommentsTarget> {
  Offset? startOffset;
  Offset? currentOffset;

  @override
  Widget build(BuildContext context) {
    return Consumer<NodeEditorModel>(builder: (context, model, _) {
      return SizedBox.expand(
          child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (var comment in model.comments)
                  Transform(
                    transform: model.transformationController.value *
                        Matrix4.translation(Vector3(comment.designer.position.x, comment.designer.position.y, 0)),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade800, width: 4),
                        color: Colors.blue.shade500.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: comment.width,
                      height: comment.height,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        comment.label,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                )
              ]
          ));
    });
  }
}

class CommentArea extends StatelessWidget {
  final NodeCommentArea comment;

  const CommentArea({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    var color = DESIGNER_COLORS[comment.designer.color]!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 4),
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      width: comment.width,
      height: comment.height,
      padding: EdgeInsets.all(10),
      child: comment.hasLabel() ? Text(
        comment.label,
        style: TextStyle(
          fontSize: 20,
        ),
      ) : null,
    );
  }
}

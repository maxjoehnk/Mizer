import 'package:flutter/material.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
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
                  _buildComment(model, comment)
              ]
          ));
    });
  }

  Widget _buildComment(NodeEditorModel model, NodeCommentArea comment) {
    return Transform(
      transform: model.transformationController.value *
          Matrix4.translation(Vector3(comment.designer.position.x * MULTIPLIER, comment.designer.position.y * MULTIPLIER, 0)),
      child: CommentArea(comment: comment),
    );
  }
}

class CommentArea extends StatelessWidget {
  final NodeCommentArea comment;

  const CommentArea({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    var color = DESIGNER_COLORS[comment.designer.color]!;
    return OverflowBox(
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () => context.read<NodeEditorModel>().selectComment(comment),
        behavior: HitTestBehavior.translucent,
        child: ContextMenu(
          menu: Menu(
            items: [
              MenuItem(
                label: 'Delete',
                action: () => context.read<NodesBloc>().add(DeleteComment(comment)),
              )
            ]
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 4),
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            width: comment.width * MULTIPLIER,
            height: comment.height * MULTIPLIER,
            padding: EdgeInsets.all(10),
            child: comment.hasLabel() ? Text(
              comment.label,
              style: TextStyle(
                fontSize: 20,
              ),
            ) : null,
          ),
        ),
      ),
    );
  }
}

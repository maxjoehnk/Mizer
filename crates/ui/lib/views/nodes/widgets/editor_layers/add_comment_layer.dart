import 'package:flutter/material.dart';
import 'package:mizer/widgets/interactive_surface/interactive_surface.dart';

class AddCommentLayer extends DragSelectionLayer {
  final Function(Rect) onAddComment;

  AddCommentLayer(
      {required this.onAddComment,
      required super.transformation,
      required super.selectionState,
      required super.onUpdateSelection});

  @override
  void onSelection(BuildContext context, Rect rect) {
    this.onAddComment(rect);
  }

  @override
  bool shouldIgnore(Offset position) {
    return false;
  }
}

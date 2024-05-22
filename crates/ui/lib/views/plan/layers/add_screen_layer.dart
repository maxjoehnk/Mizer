import 'package:flutter/material.dart';
import 'package:mizer/widgets/interactive_surface/interactive_surface.dart';

class AddScreenLayer extends DragSelectionLayer {
  final Function(Rect) onAddScreen;

  AddScreenLayer(
      {required this.onAddScreen,
      required super.transformation,
      required super.selectionState,
      required super.onUpdateSelection});

  @override
  void onSelection(BuildContext context, Rect rect) {
    this.onAddScreen(rect);
  }

  @override
  bool shouldIgnore(Offset position) {
    return false;
  }
}

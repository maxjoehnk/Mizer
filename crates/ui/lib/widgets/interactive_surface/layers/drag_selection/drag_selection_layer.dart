import 'package:flutter/material.dart';

import 'area_selection.dart';
import 'selection_state.dart';

abstract class DragSelectionLayer extends StatelessWidget {
  final Matrix4 transformation;
  final SelectionState? selectionState;
  final Function(SelectionState?) onUpdateSelection;

  const DragSelectionLayer(
      {required this.transformation,
      required this.selectionState,
      required this.onUpdateSelection,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragAreaSelection(
        onSelect: (selection) => this._onSelection(context, selection),
        onUpdate: onUpdateSelection,
        shouldIgnore: this.shouldIgnore,
        transformation: transformation);
  }

  bool shouldIgnore(Offset position);

  void onSelection(BuildContext context, Rect rect);

  void _onSelection(BuildContext context, Rect rect) {
    rect = MatrixUtils.inverseTransformRect(transformation, rect);
    this.onSelection(context, rect);

    onUpdateSelection(null);
  }
}

import 'package:flutter/gestures.dart';

import 'package:mizer/widgets/interactive_surface/layers/drag_selection/selection_state.dart';
import 'package:flutter/material.dart';

class DragAreaSelection extends StatefulWidget {
  final void Function(SelectionState) onUpdate;
  final void Function(Rect) onSelect;
  final bool Function(Offset)? shouldIgnore;
  final Matrix4 transformation;

  DragAreaSelection(
      {required this.onUpdate,
      required this.onSelect,
      this.shouldIgnore,
      required this.transformation})
      : super();

  @override
  State<DragAreaSelection> createState() => _DragAreaSelectionState();
}

class _DragAreaSelectionState extends State<DragAreaSelection> {
  SelectionState? state;

  @override
  Widget build(BuildContext context) {
    var onEnd = (DragEndDetails e) {
      widget.onSelect(Rect.fromPoints(state!.start, state!.end));
      setState(() {
        state = null;
      });
    };
    var onStart = (DragStartDetails e) {
      if (_shouldIgnore(e)) {
        return;
      }
      setState(() {
        state = SelectionState(e.localPosition);
        widget.onUpdate(state!);
      });
    };
    var onUpdate = (DragUpdateDetails e) {
      setState(() {
        state!.update(e.localPosition);
        widget.onUpdate(state!);
      });
    };
    return RawGestureDetector(
      behavior: HitTestBehavior.translucent,
      gestures: {
        PanGestureRecognizer: GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
            () => PanGestureRecognizer(supportedDevices: [PointerDeviceKind.mouse].toSet()),
            (PanGestureRecognizer recognizer) {
          recognizer
            ..onStart = onStart
            ..onEnd = onEnd
            ..onUpdate = onUpdate;
        })
      },
      child: SizedBox.expand(),
    );
  }

  bool _shouldIgnore(DragStartDetails startDetails) {
    if (widget.shouldIgnore == null) {
      return false;
    }
    var position =
        MatrixUtils.transformPoint(Matrix4.inverted(widget.transformation), startDetails.localPosition);
    return widget.shouldIgnore!(position);
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:provider/provider.dart';

const double fieldSize = 24;

class DragSelectionLayer extends StatelessWidget {
  final List<NodeModel> nodes;
  final Matrix4 transformation;
  final SelectionState? selectionState;
  final Function(SelectionState?) onUpdateSelection;

  const DragSelectionLayer(
      {required this.nodes,
      required this.transformation,
      required this.selectionState,
      required this.onUpdateSelection,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragAreaSelection(
        onSelect: (selection) => this._onSelection(context, selection),
        onUpdate: onUpdateSelection,
        nodes: nodes,
        transformation: transformation);
  }

  void _onSelection(BuildContext context, Rect rect) {
    rect = MatrixUtils.inverseTransformRect(transformation, rect);
    List<NodeModel> selection = this
        .nodes
        .where((node) => node.rect.overlaps(rect))
        .toList();

    NodeEditorModel model = context.read();
    model.selectAdditionalNodes(selection);

    onUpdateSelection(null);
  }
}

class DragAreaSelection extends StatefulWidget {
  final void Function(SelectionState) onUpdate;
  final void Function(Rect) onSelect;
  final List<NodeModel> nodes;
  final Matrix4 transformation;

  DragAreaSelection(
      {required this.onUpdate,
      required this.onSelect,
      required this.transformation,
      required this.nodes})
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
      if (_hitsNode(e)) {
        return;
      }
      setState(() {
        state = SelectionState(e.localPosition);
        widget.onUpdate(state!);
      });
    };
    var onUpdate = (DragUpdateDetails e) {
      setState(() {
        state!.end = e.localPosition;
        widget.onUpdate(state!);
      });
    };
    return RawGestureDetector(
      behavior: HitTestBehavior.translucent,
      gestures: {
        PanGestureRecognizer: GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
            () => PanGestureRecognizer(supportedDevices: [PointerDeviceKind.mouse].toSet()), (PanGestureRecognizer recognizer) {
          recognizer
            ..onStart = onStart
            ..onEnd = onEnd
            ..onUpdate = onUpdate;
        })
      },
      child: SizedBox.expand(),
    );
  }

  bool _hitsNode(DragStartDetails e) {
    var position =
        MatrixUtils.transformPoint(Matrix4.inverted(widget.transformation), e.localPosition);

    return this.widget.nodes.any((node) => node.rect.contains(position));
  }
}

class SelectionState {
  Offset start;
  Offset end;

  SelectionState(Offset start)
      : this.start = start,
        this.end = start;
}

class SelectionIndicator extends StatelessWidget {
  final SelectionState state;

  const SelectionIndicator(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1000, 1000),
      foregroundPainter: DragPainter(state.start, state.end),
    );
  }
}

class DragPainter extends CustomPainter {
  Offset? start;
  Offset? end;

  DragPainter(this.start, this.end) : super();

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) {
      return;
    }
    Paint fill = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    Paint stroke = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var rect = RRect.fromRectAndRadius(Rect.fromPoints(start!, end!), Radius.circular(2));
    canvas.drawRRect(rect, fill);
    canvas.drawRRect(rect, stroke);
  }

  @override
  bool shouldRepaint(covariant DragPainter oldDelegate) {
    return oldDelegate.start != this.start || oldDelegate.end != this.end;
  }
}

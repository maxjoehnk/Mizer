import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';

const double fieldSize = 24;

class DragSelectionLayer extends StatelessWidget {
  final Plan plan;
  final Matrix4 transformation;
  final SelectionState? selectionState;
  final Function(SelectionState?) onUpdateSelection;

  const DragSelectionLayer(
      {required this.plan,
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
        plan: plan,
        transformation: transformation);
  }

  void _onSelection(BuildContext context, Rect rect) {
    rect = MatrixUtils.inverseTransformRect(transformation, rect);
    List<FixtureId> selection = this
        .plan
        .positions
        .where((fixture) {
          var fixturePosition = _convertToScreenPosition(fixture);
          var fixtureEnd = fixturePosition.translate(fieldSize, fieldSize);
          var fixtureRect = Rect.fromPoints(fixturePosition, fixtureEnd);

          return fixtureRect.overlaps(rect);
        })
        .map((fixture) => fixture.id)
        .toSet()
        .toList();

    ProgrammerApi programmerApi = context.read();
    programmerApi.selectFixtures(selection);

    onUpdateSelection(null);
  }
}

class DragAreaSelection extends StatefulWidget {
  final void Function(SelectionState) onUpdate;
  final void Function(Rect) onSelect;
  final Plan plan;
  final Matrix4 transformation;

  DragAreaSelection(
      {required this.onUpdate,
      required this.onSelect,
      required this.transformation,
      required this.plan})
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
      if (_hitsFixture(e)) {
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
            () => PanGestureRecognizer(), (PanGestureRecognizer recognizer) {
          recognizer
            ..onStart = onStart
            ..onEnd = onEnd
            ..onUpdate = onUpdate;
        })
      },
      child: SizedBox.expand(),
    );
  }

  bool _hitsFixture(DragStartDetails e) {
    var position =
        MatrixUtils.transformPoint(Matrix4.inverted(widget.transformation), e.localPosition);

    var hitsFixture = this.widget.plan.positions.any((fixture) {
      var fixturePosition = _convertToScreenPosition(fixture);
      var fixtureEnd = fixturePosition.translate(fieldSize, fieldSize);
      var fixtureRect = Rect.fromPoints(fixturePosition, fixtureEnd);

      return fixtureRect.contains(position);
    });
    return hitsFixture;
  }
}

Offset _convertToScreenPosition(FixturePosition fixture) {
  return Offset(fixture.x.toDouble(), fixture.y.toDouble()) * fieldSize;
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

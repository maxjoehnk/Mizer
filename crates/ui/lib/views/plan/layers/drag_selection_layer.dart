import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/i18n.dart';
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
    var positions = this.plan.positions.where((fixture) {
      var fixturePosition = _convertToScreenPosition(fixture);
      var fixtureEnd = fixturePosition.translate(fieldSize, fieldSize);
      var fixtureRect = Rect.fromPoints(fixturePosition, fixtureEnd);

      return fixtureRect.overlaps(rect);
    }).toList();
    selectionState!.reorderFixtures(positions);
    List<FixtureId> selection = positions.map((fixture) => fixture.id).distinct().toList();

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
        state!.update(e.localPosition);
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
  SelectionDirection? direction;

  SelectionState(Offset start)
      : this.start = start,
        this.end = start;

  void update(Offset localPosition) {
    this.end = localPosition;
    var offset = this.start - this.end;
    if (direction == null) {
      Axis primaryAxis = offset.dx.abs() > offset.dy.abs() ? Axis.horizontal : Axis.vertical;
      direction = SelectionDirection(primaryAxis);
    }
    direction!.update(offset);
  }

  void reorderFixtures(List<FixturePosition> positions) {
    if (direction == null) {
      return;
    }
    if (direction!.primaryAxis == Axis.horizontal) {
      _reorderHorizontal(positions);
    } else {
      _reorderVertical(positions);
    }
  }

  void _reorderHorizontal(List<FixturePosition> positions) {
    positions.sort((a, b) {
      var verticalOrder = direction!.vertical == AxisDirection.up ? b.y - a.y : a.y - b.y;
      if (verticalOrder != 0) {
        return verticalOrder;
      }

      return direction!.horizontal == AxisDirection.right ? b.x - a.x : a.x - b.x;
    });
  }

  void _reorderVertical(List<FixturePosition> positions) {
    positions.sort((a, b) {
      var horizontalOrder = direction!.horizontal == AxisDirection.right ? b.x - a.x : a.x - b.x;
      if (horizontalOrder != 0) {
        return horizontalOrder;
      }

      return direction!.vertical == AxisDirection.up ? b.y - a.y : a.y - b.y;
    });
  }
}

class SelectionDirection {
  Axis primaryAxis;
  AxisDirection vertical;
  AxisDirection horizontal;

  SelectionDirection(this.primaryAxis)
      : vertical = AxisDirection.up,
        horizontal = AxisDirection.right;

  update(Offset offset) {
    vertical = offset.dy > 0 ? AxisDirection.up : AxisDirection.down;
    horizontal = offset.dx > 0 ? AxisDirection.right : AxisDirection.left;
  }

  @override
  String toString() {
    String verticalName =
        vertical == AxisDirection.up ? "Bottom to Top".i18n : "Top to Bottom".i18n;
    String horizontalName =
        horizontal == AxisDirection.right ? "Right to Left".i18n : "Left to Right".i18n;

    return primaryAxis == Axis.vertical
        ? "$verticalName -> $horizontalName"
        : "$horizontalName -> $verticalName";
  }
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

class SelectionDirectionIndicator extends StatelessWidget {
  final SelectionDirection direction;

  const SelectionDirectionIndicator(this.direction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 8,
      child: Text(direction.toString()),
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

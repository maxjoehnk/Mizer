import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/extensions/fixture_id_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/state/plans_bloc.dart';

const double fieldSize = 24;

class PlanLayout extends StatefulWidget {
  final Plan plan;
  final ProgrammerState? programmerState;
  final bool setupMode;

  const PlanLayout({required this.plan, this.programmerState, required this.setupMode, Key? key})
      : super(key: key);

  @override
  State<PlanLayout> createState() => _PlanLayoutState();
}

class _PlanLayoutState extends State<PlanLayout> with SingleTickerProviderStateMixin {
  final TransformationController _transformationController = TransformationController();
  FixturesRefPointer? _fixturesPointer;
  SelectionState? _selectionState;

  @override
  void initState() {
    super.initState();
    PlansApi plansApi = context.read();
    plansApi.getFixturesPointer().then((pointer) {
      setState(() {
        _fixturesPointer = pointer;
      });
    });
  }

  @override
  void dispose() {
    _fixturesPointer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fixturesPointer == null) {
      return Container();
    }
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 5,
      scaleFactor: 500,
      transformationController: _transformationController,
      child: DragTarget(
        onWillAccept: (details) => details is FixturePosition,
        onAcceptWithDetails: (details) {
          var renderBox = context.findRenderObject() as RenderBox;
          var local = renderBox.globalToLocal(details.offset);
          var scene = _transformationController.toScene(local);
          var newPosition = _convertFromScreenPosition(scene);
          var fixturePosition = details.data as FixturePosition;
          var movement =
              Offset(newPosition.dx - fixturePosition.x, newPosition.dy - fixturePosition.y);

          PlansBloc bloc = context.read();
          if (widget.programmerState?.activeFixtures.isEmpty ?? true) {
            bloc.add(MoveFixture(id: fixturePosition.id, x: movement.dx, y: movement.dy));
          } else {
            bloc.add(MoveFixtureSelection(x: movement.dx, y: movement.dy));
          }
        },
        builder: (context, candidates, rejects) => Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
                width: 1000,
                height: 1000,
                child: DragDropSelection(
                    onSelect: this._onSelection, onUpdate: this._onUpdateSelection)),
            CustomMultiChildLayout(delegate: PlanLayoutDelegate(widget.plan), children: [
              ..._fixtures,
              ..._screens,
            ]),
            if (_selectionState != null) SelectionIndicator(_selectionState!),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> get _fixtures {
    return widget.plan.positions.map((p) {
                var selected = widget.programmerState?.activeFixtures
                        .firstWhereOrNull((f) => f.overlaps(p.id)) !=
                    null;
                var child = Fixture2DView(
                    fixture: p,
                    ref: _fixturesPointer!,
                    selected: selected,
                    onSelect: () => this._addFixtureToSelection(p.id),
                    onUnselect: () => this._removeFixtureFromSelection(p.id));
                return LayoutId(
                    id: p.id,
                    child: widget.setupMode
                        ? Draggable(
                            hitTestBehavior: HitTestBehavior.translucent,
                            data: p,
                            feedback: _getDragFeedback(p),
                            child: MouseRegion(child: child, cursor: SystemMouseCursors.move),
                          )
                        : MouseRegion(child: child, cursor: SystemMouseCursors.click));
              });
  }

  Iterable<Widget> get _screens {
    return widget.plan.screens.map((s) {
      return LayoutId(id: "screen-${s.id}", child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: Colors.white,
              width: 1,
              strokeAlign: StrokeAlign.center,
              style: BorderStyle.solid,
            )
          )
        ),
      ));
    });
  }

  void _onSelection(Rect rect) {
    List<FixtureId> selection = this
        .widget
        .plan
        .positions
        .where((fixture) {
          var fixturePosition = _convertToScreenPosition(fixture);
          var fixtureEnd = fixturePosition.translate(fieldSize, fieldSize);
          var fixtureRect = Rect.fromPoints(fixturePosition, fixtureEnd);

          return fixtureRect.overlaps(rect);
        })
        .map((fixture) => fixture.id)
        .toList();
    selection.addAll(widget.programmerState!.fixtures);
    selection = selection.toSet().toList();

    ProgrammerApi programmerApi = context.read();
    programmerApi.selectFixtures(selection);
    setState(() {
      this._selectionState = null;
    });
  }

  void _addFixtureToSelection(FixtureId fixtureId) {
    ProgrammerApi programmerApi = context.read();
    programmerApi.selectFixtures([fixtureId]);
  }

  void _removeFixtureFromSelection(FixtureId fixtureId) {
    ProgrammerApi programmerApi = context.read();
    programmerApi.unselectFixtures([fixtureId]);
  }

  void _onUpdateSelection(SelectionState state) {
    setState(() {
      this._selectionState = state;
    });
  }

  Widget _getDragFeedback(FixturePosition position) {
    var textStyle = Theme.of(context).textTheme.bodyMedium;
    if (widget.programmerState?.fixtures.isEmpty ?? true) {
      return Fixture2DView(
          fixture: position, ref: _fixturesPointer!, selected: true, textStyle: textStyle);
    }

    var selectedFixtures = widget.plan.positions
        .where((p) => widget.programmerState?.fixtures.contains(p.id) ?? false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: selectedFixtures
          .map((p) => Fixture2DView(
              fixture: p, ref: _fixturesPointer!, selected: true, textStyle: textStyle))
          .toList(),
    );
  }
}

class Fixture2DView extends StatefulWidget {
  final FixturePosition fixture;
  final FixturesRefPointer ref;
  final bool selected;
  final TextStyle? textStyle;
  final Function()? onSelect;
  final Function()? onUnselect;

  const Fixture2DView(
      {required this.fixture,
      required this.ref,
      this.onSelect,
      this.onUnselect,
      this.selected = true,
      this.textStyle,
      Key? key})
      : super(key: key);

  @override
  State<Fixture2DView> createState() => _Fixture2DViewState();
}

class _Fixture2DViewState extends State<Fixture2DView> with SingleTickerProviderStateMixin {
  Ticker? ticker;
  FixtureState state = FixtureState();

  @override
  void initState() {
    super.initState();
    ticker = this.createTicker((elapsed) {
      setState(() {
        state = widget.ref.readState(widget.fixture.id);
      });
    });
    ticker!.start();
  }

  @override
  void dispose() {
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 6;
    return GestureDetector(
      onTap: () {
        if (RawKeyboard.instance.keysPressed.any((key) => [
              LogicalKeyboardKey.shift,
              LogicalKeyboardKey.shiftLeft,
              LogicalKeyboardKey.shiftRight,
            ].contains(key))) {
          if (widget.onUnselect != null) {
            widget.onUnselect!();
          }
        } else {
          if (widget.onSelect != null) {
            widget.onSelect!();
          }
        }
      },
      child: Container(
          width: fieldSize,
          height: fieldSize,
          padding: const EdgeInsets.all(2),
          child: Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(
                    color: widget.selected ? Colors.grey.shade500 : Colors.grey.shade800,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                color: state.getColor(),
              ),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.fixture.id.toDisplay(),
                      style: widget.textStyle?.copyWith(fontSize: fontSize) ??
                          TextStyle(fontSize: fontSize))))),
    );
  }
}

class PlanLayoutDelegate extends MultiChildLayoutDelegate {
  final Plan plan;

  PlanLayoutDelegate(this.plan);

  @override
  void performLayout(Size size) {
    for (var fixture in plan.positions) {
      var size = Size.square(fieldSize);
      layoutChild(fixture.id, BoxConstraints.tight(size));
      var offset = _convertToScreenPosition(fixture);
      positionChild(fixture.id, offset);
    }
    for (var screen in plan.screens) {
      var screenId = "screen-${screen.id}";
      var size = Size(
        screen.width * fieldSize,
        screen.height * fieldSize
      );
      layoutChild(screenId, BoxConstraints.tight(size));
      var offset = _convertScreenToScreenPosition(screen);
      positionChild(screenId, offset);
    }
  }

  @override
  bool shouldRelayout(covariant PlanLayoutDelegate oldDelegate) {
    return plan.positions != oldDelegate.plan.positions;
  }
}

class DragDropSelection extends StatefulWidget {
  final void Function(SelectionState) onUpdate;
  final void Function(Rect) onSelect;

  DragDropSelection({required this.onUpdate, required this.onSelect}) : super();

  @override
  State<DragDropSelection> createState() => _DragDropSelectionState();
}

class _DragDropSelectionState extends State<DragDropSelection> {
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
      child: SizedBox(
        width: 1000,
        height: 1000,
      ),
    );
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

class SelectionState {
  Offset start;
  Offset end;

  SelectionState(Offset start)
      : this.start = start,
        this.end = start;
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

Offset _convertToScreenPosition(FixturePosition fixture) {
  return Offset(fixture.x.toDouble(), fixture.y.toDouble()) * fieldSize;
}

Offset _convertFromScreenPosition(Offset offset) {
  return offset / fieldSize;
}

Offset _convertScreenToScreenPosition(PlanScreen screen) {
  return Offset(screen.x.toDouble(), screen.y.toDouble()) * fieldSize;
}

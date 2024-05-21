import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/extensions/fixture_id_extensions.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/plans_bloc.dart';

const double fieldSize = 24;

class PlansFixturesLayer extends StatefulWidget {
  final Plan plan;
  final ProgrammerState? programmerState;
  final bool setupMode;
  final FixturesRefPointer fixturesPointer;

  const PlansFixturesLayer(
      {required this.plan,
      required this.programmerState,
      required this.setupMode,
      required this.fixturesPointer,
      Key? key})
      : super(key: key);

  @override
  State<PlansFixturesLayer> createState() => _PlansFixturesLayerState();
}

class _PlansFixturesLayerState extends State<PlansFixturesLayer> {
  Offset? movingOffset;
  FixtureId? movingFixtureId;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomMultiChildLayout(
          delegate: PlanFixturesLayoutDelegate(widget.plan, widget.programmerState?.activeFixtures, movingFixtureId, movingOffset), children: _getFixtures(context)),
    );
  }

  List<Widget> _getFixtures(BuildContext context) {
    var fixturesBloc = context.read<FixturesBloc>();
    return widget.plan.positions.map((p) {
      var selected =
          widget.programmerState?.activeFixtures.firstWhereOrNull((f) => f.overlaps(p.id)) != null;
      var tracked = widget.programmerState?.fixtures.firstWhereOrNull((f) => f.overlaps(p.id)) != null;
      var child = Fixture2DView(
          position: p,
          fixture: fixturesBloc.state.fixtures.firstWhereOrNull((f) => f.id == p.id.fixtureId),
          ref: widget.fixturesPointer,
          tracked: tracked,
          selected: selected,
          onSelect: () => this._addFixtureToSelection(context, p.id),
          onUnselect: () => this._removeFixtureFromSelection(context, p.id),
          onFinishDrag: _onFinishDrag,
          onUpdateDrag: (offset) => setState(() {
            movingOffset = offset;
            movingFixtureId = p.id;
          }),
      );
      return LayoutId(
          id: p.id,
          child: MouseRegion(child: child, cursor: widget.setupMode ? SystemMouseCursors.move : SystemMouseCursors.click));
    }).toList();
  }

  void _addFixtureToSelection(BuildContext context, FixtureId fixtureId) {
    ProgrammerApi programmerApi = context.read();
    programmerApi.selectFixtures([fixtureId]);
  }

  void _removeFixtureFromSelection(BuildContext context, FixtureId fixtureId) {
    ProgrammerApi programmerApi = context.read();
    programmerApi.unselectFixtures([fixtureId]);
  }

  void _onFinishDrag() {
    if (this.movingOffset == null) {
      return;
    }
    var movement = this.movingOffset! / fieldSize;

    PlansBloc bloc = context.read();
    List<FixtureId> selectedFixtures = [];
    if (widget.programmerState?.activeFixtures != null) {
      selectedFixtures = widget.programmerState!.activeFixtures;
    }
    if (widget.programmerState?.activeFixtures.isEmpty == true || !selectedFixtures.contains(movingFixtureId!)) {
      bloc.add(MoveFixture(id: movingFixtureId!, x: movement.dx, y: movement.dy));
    } else {
      bloc.add(MoveFixtureSelection(x: movement.dx, y: movement.dy));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        this.movingOffset = null;
      });
    });
  }
}

class Fixture2DView extends StatefulWidget {
  final FixturePosition position;
  final FixturesRefPointer ref;
  final bool tracked;
  final bool selected;
  final TextStyle? textStyle;
  final Function()? onSelect;
  final Function()? onUnselect;
  final Fixture? fixture;
  final Function(Offset)? onUpdateDrag;
  final Function()? onFinishDrag;

  const Fixture2DView(
      {required this.position,
      required this.ref,
      this.onSelect,
      this.onUnselect,
      this.tracked = false,
      this.selected = false,
      this.textStyle,
      this.onUpdateDrag,
      this.onFinishDrag,
      Key? key, this.fixture})
      : super(key: key);

  @override
  State<Fixture2DView> createState() => _Fixture2DViewState();
}

class _Fixture2DViewState extends State<Fixture2DView> with SingleTickerProviderStateMixin {
  Ticker? ticker;
  FixtureState state = FixtureState();
  Offset? startOffset;

  @override
  void initState() {
    super.initState();
    ticker = this.createTicker((elapsed) {
      setState(() {
        state = widget.ref.readState(widget.position.id);
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
    var color = widget.tracked ? Colors.deepOrange : null;
    var textStyle = (widget.textStyle ?? TextStyle()).copyWith(fontSize: fontSize, color: color);
    return GestureDetector(
      onPanStart: (e) {
        setState(() {
          startOffset = e.localPosition;
        });
        widget.onUpdateDrag?.call(Offset.zero);
      },
      onPanUpdate: (e) {
        if (HardwareKeyboard.instance.isShiftPressed) {
          widget.onUpdateDrag?.call(e.localPosition - startOffset!);
        }else {
          var snappedStart = startOffset! - Offset(startOffset!.dx % fieldSize, startOffset!.dy % fieldSize);
          var snappedEnd = e.localPosition - Offset(e.localPosition.dx % fieldSize, e.localPosition.dy % fieldSize);
          widget.onUpdateDrag?.call(snappedEnd - snappedStart);
        }
      },
      onPanEnd: (e) {
        widget.onFinishDrag?.call();
        setState(() {
          startOffset = null;
        });
      },
      onTap: () {
        if (HardwareKeyboard.instance.logicalKeysPressed.any((key) => [
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
          width: fieldSize * widget.position.width,
          height: fieldSize * widget.position.height,
          padding: const EdgeInsets.all(1),
          child: Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(
                    color: widget.selected ? Colors.grey.shade500 : Colors.grey.shade800,
                    width: widget.position.width,
                    style: BorderStyle.solid,
                  ),
                ),
                color: state.getColor(),
              ),
              child: widget.position.width >= 1 && widget.position.height >= 1 ? Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.position.id.toDisplay(), style: textStyle)) : null)),
    );
  }
}

class PlanFixturesLayoutDelegate extends MultiChildLayoutDelegate {
  final Plan plan;
  final List<FixtureId>? selectedFixtures;
  final FixtureId? movingFixture;
  final Offset? movingOffset;

  PlanFixturesLayoutDelegate(this.plan, this.selectedFixtures, this.movingFixture, this.movingOffset);

  @override
  void performLayout(Size size) {
    var selectedFixtures = [];
    if (this.selectedFixtures != null) {
      selectedFixtures = this.selectedFixtures!;
    }
    if (movingFixture != null && !selectedFixtures.contains(movingFixture)) {
      selectedFixtures = [movingFixture!];
    }
    for (var fixture in plan.positions) {
      var size = Size(fieldSize * fixture.width, fieldSize * fixture.height);
      layoutChild(fixture.id, BoxConstraints.tight(size));
      var offset = _convertToScreenPosition(fixture);
      if (selectedFixtures.contains(fixture.id)) {
        offset += movingOffset ?? Offset.zero;
      }
      positionChild(fixture.id, offset);
    }
  }

  @override
  bool shouldRelayout(covariant PlanFixturesLayoutDelegate oldDelegate) {
    return plan.positions != oldDelegate.plan.positions ||
        selectedFixtures != oldDelegate.selectedFixtures ||
        movingOffset != oldDelegate.movingOffset;
  }
}

Offset _convertToScreenPosition(FixturePosition fixture) {
  return Offset(fixture.x.toDouble(), fixture.y.toDouble()) * fieldSize;
}

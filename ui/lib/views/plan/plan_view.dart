import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/api/plugin/ffi/programmer.dart';
import 'package:mizer/extensions/fixture_id_extensions.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/views/plan/dialogs/select_group_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'dialogs/name_layout_dialog.dart';

const double fieldSize = 24;

class PlanView extends StatefulWidget {
  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> with SingleTickerProviderStateMixin {
  ProgrammerStatePointer? _programmerPointer;
  Ticker? _ticker;
  ProgrammerState? _programmerState;

  @override
  void initState() {
    super.initState();
    ProgrammerApi programmerApi = context.read();
    programmerApi.getProgrammerPointer().then((pointer) {
      if (pointer == null) {
        return;
      }
      setState(() {
        _programmerPointer = pointer;
      });
      _ticker = createTicker((elapsed) {
        setState(() => _programmerState = pointer.readState());
      });
      _ticker!.start();
    });
  }

  @override
  void dispose() {
    _programmerPointer?.dispose();
    _ticker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlansBloc plansBloc = context.read();
    return BlocBuilder<PlansBloc, PlansState>(builder: (context, state) {
      return HotkeyProvider(
        hotkeySelector: (hotkeys) => hotkeys.plan,
        hotkeyMap: {
          "store": _storeInGroup,
          "highlight": _highlight,
        },
        child: tabs.Tabs(
          tabIndex: state.tabIndex,
          onSelectTab: (index) => plansBloc.add(SelectPlanTab(index)),
          padding: false,
          children: state.plans
              .map((plan) => tabs.Tab(
                  header: (active, setActive) => ContextMenu(
                      menu: Menu(items: [
                        MenuItem(label: "Rename", action: () => _onRename(context, plan, plansBloc)),
                        MenuItem(label: "Delete", action: () => _onDelete(context, plan, plansBloc)),
                      ]),
                      child: tabs.TabHeader(plan.name, selected: active, onSelect: setActive)),
                  child: PlanLayout(plan: plan, programmerState: _programmerState)))
              .toList(),
          onAdd: () => _addPlan(context, plansBloc),
          actions: [
            PanelAction(hotkeyId: "highlight", label: "Highlight", onClick: _highlight, activated: _programmerState?.highlight ?? false),
            PanelAction(hotkeyId: "store", label: "Store", onClick: _storeInGroup),
          ],
        ),
      );
    });
  }

  Future<void> _addPlan(BuildContext context, PlansBloc plansBloc) {
    return showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => NamePlanDialog(),
    ).then((name) => plansBloc.add(AddPlan(name: name)));
  }

  void _onDelete(BuildContext context, Plan plan, PlansBloc bloc) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Delete Plan"),
              content: SingleChildScrollView(
                child: Text("Delete Plan ${plan.name}?"),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  autofocus: true,
                  child: Text("Delete"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
    if (result) {
      bloc.add(RemovePlan(id: plan.name));
    }
  }

  void _onRename(BuildContext context, Plan plan, PlansBloc bloc) async {
    String? result =
        await showDialog(context: context, builder: (context) => NamePlanDialog(name: plan.name));
    if (result != null) {
      bloc.add(RenamePlan(id: plan.name, name: result));
    }
  }

  void _storeInGroup() async {
    ProgrammerApi programmerApi = context.read();
    var group = await showDialog(context: context, builder: (context) => SelectGroupDialog(api: programmerApi));
    if (group == null) {
      return;
    }
    await programmerApi.assignFixtureSelectionToGroup(group);
  }

  void _highlight() {
    ProgrammerApi programmerApi = context.read();
    programmerApi.highlight(!(_programmerState?.highlight ?? false));
  }
}

class PlanLayout extends StatefulWidget {
  final Plan plan;
  final ProgrammerState? programmerState;

  const PlanLayout({required this.plan, this.programmerState, Key? key}) : super(key: key);

  @override
  State<PlanLayout> createState() => _PlanLayoutState();
}

class _PlanLayoutState extends State<PlanLayout> with SingleTickerProviderStateMixin {
  FixturesRefPointer? _fixturesPointer;

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
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomMultiChildLayout(
            delegate: PlanLayoutDelegate(widget.plan),
            children: widget.plan.positions.map((p) {
              var selected =
                  widget.programmerState?.fixtures.firstWhereOrNull((f) => f.overlaps(p.id)) != null;
              return LayoutId(
                  id: p.id,
                  child: Fixture2DView(fixture: p, ref: _fixturesPointer!, selected: selected));
            }).toList()),
        SizedBox(width: 1000, height: 1000, child: DragDropSelection(onSelect: this._onSelection)),
      ],
    );
  }

  void _onSelection(Rect rect) {
    var selection = this
        .widget
        .plan
        .positions
        .where((fixture) => rect.contains(_convertToScreenPosition(fixture)))
        .map((fixture) => fixture.id)
        .toList();

    ProgrammerApi programmerApi = context.read();
    programmerApi.selectFixtures(selection);
  }
}

class Fixture2DView extends StatefulWidget {
  final FixturePosition fixture;
  final FixturesRefPointer ref;
  final bool selected;

  const Fixture2DView({required this.fixture, required this.ref, this.selected = true, Key? key})
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
    return Container(
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
        )));
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
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

class DragDropSelection extends StatefulWidget {
  final void Function(Rect) onSelect;

  DragDropSelection({required this.onSelect}) : super();

  @override
  State<DragDropSelection> createState() => _DragDropSelectionState();
}

class _DragDropSelectionState extends State<DragDropSelection> {
  Offset? start;
  Offset? end;

  @override
  Widget build(BuildContext context) {
    var onEnd = (DragEndDetails e) {
      widget.onSelect(Rect.fromPoints(start!, end!));
      setState(() {
        start = null;
        end = null;
      });
    };
    var onStart = (DragStartDetails e) {
      setState(() {
        start = e.localPosition;
        end = e.localPosition;
      });
    };
    var onUpdate = (DragUpdateDetails e) {
      setState(() {
        end = e.localPosition;
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
      child: CustomPaint(
        size: Size(1000, 1000),
        foregroundPainter: DragPainter(start, end),
      ),
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

Offset _convertToScreenPosition(FixturePosition fixture) {
  return Offset(fixture.x.toDouble(), fixture.y.toDouble()) * fieldSize;
}

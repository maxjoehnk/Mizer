import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'dialogs/name_layout_dialog.dart';

const double fieldSize = 24;

class PlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlansBloc plansBloc = context.read();
    return BlocBuilder<PlansBloc, PlansState>(builder: (context, state) {
      return tabs.Tabs(
        tabIndex: state.tabIndex,
        onSelectTab: (index) => plansBloc.add(SelectPlanTab(index)),
        padding: false,
        children: state.plans
            .map((plan) => tabs.Tab(
                header: (active, setActive) => ContextMenu(
                    menu: Menu(items: [
                      MenuItem(
                          label: "Rename", action: () => _onRename(context, plan, plansBloc)),
                      MenuItem(
                          label: "Delete", action: () => _onDelete(context, plan, plansBloc)),
                    ]),
                    child: tabs.TabHeader(plan.name, selected: active, onSelect: setActive)),
                child: PlanLayout(plan: plan)))
            .toList(),
        onAdd: () => _addPlan(context, plansBloc),
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
}

class PlanLayout extends StatefulWidget {
  final Plan plan;

  const PlanLayout({required this.plan, Key? key}) : super(key: key);

  @override
  State<PlanLayout> createState() => _PlanLayoutState();
}

class _PlanLayoutState extends State<PlanLayout> with SingleTickerProviderStateMixin {
  FixturesRefPointer? _pointer;

  @override
  void initState() {
    super.initState();
    var fixturesApi = context.read<PlansApi>();
    fixturesApi.getFixturesPointer().then((pointer) {
      setState(() {
        _pointer = pointer;
      });
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pointer == null) {
      return Container();
    }
    return CustomMultiChildLayout(
        delegate: PlanLayoutDelegate(widget.plan),
        children: widget.plan.positions
            .map((p) => LayoutId(id: p.id, child: Fixture2DView(fixture: p, ref: _pointer!)))
            .toList());
  }
}

class Fixture2DView extends StatefulWidget {
  final FixturePosition fixture;
  final FixturesRefPointer ref;

  const Fixture2DView({required this.fixture, required this.ref, Key? key}) : super(key: key);

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
              color: Colors.grey.shade800,
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
      var offset = Offset(fixture.x.toDouble(), fixture.y.toDouble()) * fieldSize;
      positionChild(fixture.id, offset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/views/plan/layers/drag_selection_layer.dart';
import 'package:mizer/views/plan/layers/fixtures_layer.dart';
import 'package:mizer/views/plan/layers/screens_layer.dart';
import 'package:mizer/views/plan/layers/transform_layer.dart';

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
    return DragTarget(
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
          Transform(transform: _transformationController.value, child: PlansScreenLayer(plan: widget.plan)),
          TransformLayer(transformationController: _transformationController),
          DragSelectionLayer(
            plan: widget.plan,
            transformation: _transformationController.value,
            selectionState: _selectionState,
            onUpdateSelection: (selection) => setState(() => _selectionState = selection),
          ),
          Transform(
            transform: _transformationController.value,
            child: PlansFixturesLayer(
              plan: widget.plan,
              setupMode: widget.setupMode,
              fixturesPointer: _fixturesPointer!,
              programmerState: widget.programmerState,
            ),
          ),
          if (_selectionState != null) SelectionIndicator(_selectionState!),
        ],
      ),
    );
  }
}

Offset _convertFromScreenPosition(Offset offset) {
  return offset / fieldSize;
}

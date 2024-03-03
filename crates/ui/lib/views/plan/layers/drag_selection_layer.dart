import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/widgets/interactive_surface/interactive_surface.dart';

const double fieldSize = 24;

class PlanDragSelectionLayer extends DragSelectionLayer {
  final Plan plan;

  PlanDragSelectionLayer({required this.plan, required super.transformation, required super.selectionState, required super.onUpdateSelection});

  @override
  void onSelection(BuildContext context, Rect rect) {
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
  }

  @override
  bool shouldIgnore(Offset position) {
    var hitsFixture = this.plan.positions.any((fixture) {
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

extension PlanSelectionState on SelectionState {
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
        return (verticalOrder * 10).round();
      }

      var result = direction!.horizontal == AxisDirection.right ? b.x - a.x : a.x - b.x;
      return (result * 10).round();
    });
  }

  void _reorderVertical(List<FixturePosition> positions) {
    positions.sort((a, b) {
      var horizontalOrder = direction!.horizontal == AxisDirection.right ? b.x - a.x : a.x - b.x;
      if (horizontalOrder != 0) {
        return (horizontalOrder * 10).round();
      }

      var result = direction!.vertical == AxisDirection.up ? b.y - a.y : a.y - b.y;
      return (result * 10).round();
    });
  }
}

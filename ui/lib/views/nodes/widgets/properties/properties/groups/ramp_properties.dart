import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/fields/spline_field.dart';
import 'package:mizer/widgets/splines/handle_state.dart';
import 'package:mizer/widgets/splines/point_state.dart';
import 'package:mizer/widgets/splines/spline_editor.dart';

import '../property_group.dart';

const double SPLINE_SIZE = 232;

class RampProperties extends StatefulWidget {
  final RampNodeConfig config;
  final Function(RampNodeConfig) onUpdate;

  RampProperties(this.config, {required this.onUpdate});

  @override
  _RampPropertiesState createState() => _RampPropertiesState(config);
}

class _RampPropertiesState extends State<RampProperties> {
  RampNodeConfig state;

  _RampPropertiesState(this.state);

  @override
  void didUpdateWidget(RampProperties oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(title: "Ramp", children: [
      SplineEditor<RampNodeConfig_RampStep, RampPointState, RampHandleState>(
        points: state.steps,
        builder: (context, points, handles) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPaint(
              painter: SplineFieldPainter(state.steps, points, handles),
              size: Size.square(SPLINE_SIZE)),
        ),
        createPoint: (step, index) => RampPointState(step, index),
        createHandle: (step, index, first) => RampHandleState(step, first, index),
        onAddPoint: (_, x, y) => _onAddPoint(x, y),
        onRemovePoint: _onRemovePoint,
        onFinishInteraction: _onFinishInteraction,
        onUpdateHandle: _onUpdateHandle,
        onUpdatePoint: _onUpdatePoint,
        translatePosition: (position) {
          double x = position.dx / SPLINE_SIZE;
          double y = (SPLINE_SIZE - position.dy) / SPLINE_SIZE;

          return Offset(x, y);
        },
      )
    ]);
  }

  void _updateSteps({List<RampNodeConfig_RampStep>? steps}) {
    log("_updateSteps $steps", name: "RampProperties");
    setState(() {
      state = RampNodeConfig(steps: steps ?? state.steps);
      widget.onUpdate(state);
    });
  }

  _onAddPoint(double x, double y) {
    var previousStep = state.steps.lastWhere((point) => point.x < x);
    var previousStepIndex = state.steps.indexOf(previousStep);
    state.steps.insert(previousStepIndex + 1, RampNodeConfig_RampStep(x: x, y: y, c0a: 0.5, c0b: 0.5, c1a: 0.5, c1b: 0.5));
    this._updateSteps();
  }

  _onRemovePoint(RampPointState point) {
    // We don't allow the first or last item to be removed so we always have two points for the ramp
    if (point.index == 0 || point.index == state.steps.lastIndex) {
      return;
    }
    this.state.steps.removeAt(point.index);
    this._updateSteps();
  }

  _onFinishInteraction({RampHandleState? handle, RampPointState? point}) {
    this._updateSteps();
  }

  _onUpdateHandle(RampHandleState handle, double x, double y) {
    x = x.clamp(0, 1);
    y = y.clamp(0, 1);
    this.setState(() {
      if (handle.first) {
        this.state.steps[handle.pointIndex].c0a = x;
        this.state.steps[handle.pointIndex].c0b = y;
      } else {
        this.state.steps[handle.pointIndex].c1a = x;
        this.state.steps[handle.pointIndex].c1b = y;
      }
    });
  }

  _onUpdatePoint(RampPointState point, double x, double y) {
    x = x.clamp(0, 1);
    y = y.clamp(0, 1);
    setState(() {
      this.state.steps[point.index].y = y;
      if (point.index == 0 || point.index == state.steps.lastIndex) {
        return;
      }
      this.state.steps[point.index].x = x;
    });
  }
}

class RampPointState extends PointState<RampNodeConfig_RampStep> {
  final int index;

  RampPointState(RampNodeConfig_RampStep data, this.index) : super(data, data.x, data.y, 0.05);

  @override
  void update(RampNodeConfig_RampStep data) {
    this.x = data.x;
    this.y = data.y;
  }
}

class RampHandleState extends HandleState<RampNodeConfig_RampStep> {
  final int pointIndex;

  RampHandleState(RampNodeConfig_RampStep data, bool first, this.pointIndex)
      : super(data, first ? data.c0a : data.c1a, first ? data.c0b : data.c1b, first, 0.05);

  @override
  void update(RampNodeConfig_RampStep data) {
    this.x = this.first ? data.c0a : data.c1a;
    this.y = this.first ? data.c0b : data.c1b;
  }
}

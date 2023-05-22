import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/splines/handle_state.dart';
import 'package:mizer/widgets/splines/point_state.dart';
import 'package:mizer/widgets/splines/spline_editor.dart';

const HANDLE_SIZE = 0.02;
const double SPLINE_SIZE = 208;

class SplineField extends StatefulWidget {
  final NodeSetting_SplineValue value;
  final Function(NodeSetting_SplineValue) onUpdate;

  const SplineField({required this.value, required this.onUpdate, Key? key}) : super(key: key);

  @override
  State<SplineField> createState() => _SplineFieldState(value);
}

class _SplineFieldState extends State<SplineField> {
  NodeSetting_SplineValue state;

  _SplineFieldState(this.state);

  @override
  void didUpdateWidget(SplineField oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SplineEditor<NodeSetting_SplineValue_SplineStep, SplinePointState, SplineHandleState>(
      points: state.steps,
      builder: (context, points, handles) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomPaint(
            painter: SplineFieldPainter(state.steps, points, handles),
            size: Size.square(SPLINE_SIZE)),
      ),
      createPoint: (step, index) => SplinePointState(step, index),
      createHandle: (step, index, first) => SplineHandleState(step, first, index),
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
    );
  }

  _onAddPoint(double x, double y) {
    var previousStep = state.steps.lastWhere((point) => point.x < x);
    var previousStepIndex = state.steps.indexOf(previousStep);
    state.steps.insert(previousStepIndex + 1,
        NodeSetting_SplineValue_SplineStep(x: x, y: y, c0a: 0.5, c0b: 0.5, c1a: 0.5, c1b: 0.5));
    this._updateSteps();
  }

  _onRemovePoint(SplinePointState point) {
    // We don't allow the first or last item to be removed so we always have two points for the ramp
    if (point.index == 0 || point.index == state.steps.lastIndex) {
      return;
    }
    this.state.steps.removeAt(point.index);
    this._updateSteps();
  }

  _onFinishInteraction({SplineHandleState? handle, SplinePointState? point}) {
    this._updateSteps();
  }

  _onUpdateHandle(SplineHandleState handle, double x, double y) {
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

  _onUpdatePoint(SplinePointState point, double x, double y) {
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

  void _updateSteps({List<NodeSetting_SplineValue_SplineStep>? steps}) {
    setState(() {
      state = NodeSetting_SplineValue(steps: steps ?? state.steps);
      widget.onUpdate(state);
    });
  }
}

class SplinePointState extends PointState<NodeSetting_SplineValue_SplineStep> {
  final int index;

  SplinePointState(NodeSetting_SplineValue_SplineStep data, this.index)
      : super(data, data.x, data.y, 0.05);

  @override
  void update(NodeSetting_SplineValue_SplineStep data) {
    this.x = data.x;
    this.y = data.y;
  }
}

class SplineHandleState extends HandleState<NodeSetting_SplineValue_SplineStep> {
  final int pointIndex;

  SplineHandleState(NodeSetting_SplineValue_SplineStep data, bool first, this.pointIndex)
      : super(data, first ? data.c0a : data.c1a, first ? data.c0b : data.c1b, first, 0.05);

  @override
  void update(NodeSetting_SplineValue_SplineStep data) {
    this.x = this.first ? data.c0a : data.c1a;
    this.y = this.first ? data.c0b : data.c1b;
  }
}

class SplineFieldPainter<TData, TPoint extends PointState<TData>,
    THandle extends HandleState<TData>> extends CustomPainter {
  final List<TData> steps;
  final List<TPoint> points;
  final List<THandle> handles;

  SplineFieldPainter(this.steps, this.points, this.handles);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(size.height, -1 * size.height);
    _drawAxis(canvas);
    _drawSecondaryAxis(canvas);
    _drawMovement(canvas);
  }

  void _drawAxis(Canvas canvas) {
    Paint axisPaint = Paint()
      ..color = Color(0x55ffffff)
      ..style = PaintingStyle.stroke;
    var xAxis = Path()
      ..moveTo(0, 0.5)
      ..lineTo(1, 0.5);
    var yAxis = Path()
      ..moveTo(0.5, 0)
      ..lineTo(0.5, 1);
    canvas.drawPath(xAxis, axisPaint);
    canvas.drawPath(yAxis, axisPaint);
    canvas.drawRect(Rect.fromLTRB(0, 1, 1, 0), axisPaint);
  }

  void _drawSecondaryAxis(Canvas canvas) {
    Paint axisPaint = Paint()
      ..color = Color(0x22ffffff)
      ..style = PaintingStyle.stroke;
    var axis = [
      Path()
        ..moveTo(0, 0.25)
        ..lineTo(1, 0.25),
      Path()
        ..moveTo(0, 0.75)
        ..lineTo(1, 0.75),
      Path()
        ..moveTo(0.25, 0)
        ..lineTo(0.25, 1),
      Path()
        ..moveTo(0.75, 0)
        ..lineTo(0.75, 1),
    ];
    axis.forEach((element) => canvas.drawPath(element, axisPaint));
  }

  void _drawMovement(Canvas canvas) {
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    var path = Path();
    var previousPoint = Offset(points.firstOrNull?.x ?? 0, points.firstOrNull?.y ?? 0);
    for (var i = 0; i < steps.length; i++) {
      var point = points[i];
      double x = point.x;
      double y = point.y;
      if (i == 0) {
        path.moveTo(x, y);
        path.lineTo(x, y);
      } else {
        var handleIndex = (i * 2).clamp(0, this.handles.length - 2);
        var handle1 = handles[handleIndex];
        var handle2 = handles[handleIndex + 1];
        path.cubicTo(handle1.x, handle1.y, handle2.x, handle2.y, x, y);
        _drawHandle(canvas, previousPoint.dx, previousPoint.dy, handle1.x, handle1.y, handle1.hit);
        _drawHandle(canvas, x, y, handle2.x, handle2.y, handle2.hit);
        previousPoint = Offset(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
    for (var point in points) {
      _drawPoint(canvas, point);
    }
  }

  void _drawHandle(Canvas canvas, double x0, double y0, double x1, double y1, bool hit) {
    Paint pathPaint = Paint()
      ..color = Color(0xaaffffff)
      ..style = PaintingStyle.stroke;
    Paint handlePaint = Paint()
      ..color = hit ? Colors.red : Colors.white54
      ..style = PaintingStyle.fill;
    var handle = Path()
      ..moveTo(x0, y0)
      ..lineTo(x1, y1);
    canvas.drawPath(handle, pathPaint);
    canvas.drawCircle(Offset(x1, y1), HANDLE_SIZE, handlePaint);
  }

  void _drawPoint(Canvas canvas, TPoint point) {
    Paint handlePaint = Paint()
      ..color = point.hit ? Colors.red : Colors.white
      ..style = PaintingStyle.fill;
    var x = point.x;
    var y = point.y;
    canvas.drawCircle(Offset(x, y), HANDLE_SIZE, handlePaint);
  }

  @override
  bool shouldRepaint(covariant SplineFieldPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.handles != handles;
  }
}

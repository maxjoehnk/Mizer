import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:mizer/widgets/splines/handle_state.dart';
import 'point_state.dart';

class SplineEditor<TData, TPoint extends PointState<TData>, THandle extends HandleState<TData>>
    extends StatefulWidget {
  final Widget Function(BuildContext, List<TPoint>, List<THandle>) builder;
  final TPoint Function(TData, int) createPoint;
  final THandle Function(TData, int, bool) createHandle;
  final List<TData> points;
  late final bool Function(TData) shouldDrawHandles;
  final Function(List<TPoint>, double, double) onAddPoint;
  final Function(TPoint) onRemovePoint;
  final Function({ TPoint? point, THandle? handle }) onFinishInteraction;
  final Function(TPoint, double, double) onUpdatePoint;
  final Function(THandle, double, double) onUpdateHandle;
  late final Offset Function(Offset) translatePosition;

  SplineEditor(
      {required this.points,
      required this.builder,
      required this.createPoint,
      required this.createHandle,
      required this.onAddPoint,
      required this.onRemovePoint,
      required this.onFinishInteraction,
      required this.onUpdateHandle,
      required this.onUpdatePoint,
      bool Function(TData)? shouldDrawHandles,
      Offset Function(Offset)? translatePosition,
      Key? key})
      : super(key: key) {
    this.shouldDrawHandles = shouldDrawHandles ?? (_) => true;
    this.translatePosition = translatePosition ?? (offset) => offset;
  }

  @override
  State<SplineEditor> createState() => _SplineEditorState<TData, TPoint, THandle>();
}

class _SplineEditorState<TData, TPoint extends PointState<TData>,
    THandle extends HandleState<TData>> extends State<SplineEditor<TData, TPoint, THandle>> {
  List<TPoint> points = [];
  List<THandle> handles = [];

  @override
  void initState() {
    super.initState();
    _setupPoints();
    _setupHandles();
  }

  @override
  void didUpdateWidget(SplineEditor<TData, TPoint, THandle> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.points.length != widget.points.length) {
      _setupPoints();
      _setupHandles();
    } else {
      List<TPoint> points = _updatePoints();
      List<THandle> handles = _updateHandles();
      setState(() {
        this.points = points;
        this.handles = handles;
      });
    }
  }

  List<TPoint> _updatePoints() {
    var points = this.points.toList();
    for (var i = 0; i < points.length; i++) {
      var data = widget.points[i];
      points[i].update(data);
    }
    return points;
  }

  List<THandle> _updateHandles() {
    var handles = this.handles.toList();
    var handleIndex = 0;
    for (var i = 0; i < widget.points.length; i++) {
      var data = widget.points[i];
      if (!widget.shouldDrawHandles(data)) {
        continue;
      }
      handles[handleIndex * 2].update(data);
      handles[handleIndex * 2 + 1].update(data);
      handleIndex += 1;
    }
    return handles;
  }

  void _setupPoints() {
    setState(() {
      this.points = widget.points.mapIndexed((i, step) => widget.createPoint(step, i)).toList();
    });
  }

  void _setupHandles() {
    List<THandle> handles = [];
    for (var i = 0; i < widget.points.length; i++) {
      var data = widget.points[i];
      if (!widget.shouldDrawHandles(data)) {
        continue;
      }
      var first = widget.createHandle(data, i, true);
      var second = widget.createHandle(data, i, false);

      handles.add(first);
      handles.add(second);
    }
    setState(() {
      this.handles = handles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: (event) {
          setState(() {
            _hitTestPoints(event);
            _hitTestHandles(event);
          });
        },
        onPointerDown: (event) {
          var position = widget.translatePosition(event.localPosition);
          if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
            var hitPoint =
                this.points.firstWhereOrNull((point) {
                  return point.isHit(position);
                });
            if (hitPoint != null) {
              widget.onRemovePoint(hitPoint);
              return;
            } else {
              widget.onAddPoint(this.points, position.dx, position.dy);
              return;
            }
          }
          List<TPoint> points = _findHitPoint(event);
          List<THandle> handles = _findHitHandle(event, points.any((p) => p.move));
          setState(() {
            this.points = points;
            this.handles = handles;
          });
        },
        onPointerUp: (_) {
          setState(() {
            for (var point in this.points) {
              if (point.move) {
                widget.onFinishInteraction(point: point);
              }
              point.move = false;
            }
            for (var handle in this.handles) {
              if (handle.move) {
                widget.onFinishInteraction(handle: handle);
              }
              handle.move = false;
            }
          });
        },
        onPointerMove: (event) {
          var position = widget.translatePosition(event.localPosition);

          var point = this.points.firstWhereOrNull((point) => point.move);
          if (point != null) {
            widget.onUpdatePoint(point, position.dx, position.dy);
          }
          var handle = this.handles.firstWhereOrNull((handle) => handle.move);
          if (handle != null) {
            widget.onUpdateHandle(handle, position.dx, position.dy);
          }
        },
        child: widget.builder(context, points, handles));
  }

  List<THandle> _findHitHandle(PointerDownEvent event, bool isPointHit) {
    var handles = this.handles.map((handle) {
      handle.move = false;
      return handle;
    }).toList();
    var hitHandle = handles.firstWhereOrNull((handle) => handle.isHit(widget.translatePosition(event.localPosition)));
    if (hitHandle != null && !isPointHit) {
      hitHandle.move = true;
    }
    return handles;
  }

  List<TPoint> _findHitPoint(PointerDownEvent event) {
    var points = this.points.map((point) {
      point.move = false;
      return point;
    }).toList();
    var hitPoint = points.firstWhereOrNull((point) => point.isHit(widget.translatePosition(event.localPosition)));
    if (hitPoint != null) {
      hitPoint.move = true;
    }
    return points;
  }

  void _hitTestHandles(PointerHoverEvent event) {
    this.handles = this.handles.map((handle) {
      handle.hit = handle.isHit(widget.translatePosition(event.localPosition));
      return handle;
    }).toList();
  }

  void _hitTestPoints(PointerHoverEvent event) {
    this.points = this.points.map((point) {
      point.hit = point.isHit(widget.translatePosition(event.localPosition));
      return point;
    }).toList();
  }
}

bool hitTest(double x0, double y0, double x1, double y1, double delta) {
  bool hitX = x0 - delta <= x1 && x0 + delta >= x1;
  bool hitY = y0 - delta <= y1 && y0 + delta >= y1;

  return hitX && hitY;
}

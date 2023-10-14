import 'package:flutter/material.dart';
import 'package:mizer/protos/surfaces.pb.dart';

const PADDING = EdgeInsets.all(8);
const double HANDLE_SIZE = 10;

class MappingDrawer extends StatefulWidget {
  final SurfaceTransform transform;
  final Function(SurfaceTransform)? onChange;
  final Function()? onConfirm;

  const MappingDrawer(this.transform, {this.onChange, this.onConfirm, super.key});

  @override
  State<MappingDrawer> createState() => _MappingDrawerState();
}

class _MappingDrawerState extends State<MappingDrawer> {
  HandleHitTest _hover = HandleHitTest(false, false, false, false);
  HandleHitTest _moving = HandleHitTest(false, false, false, false);
  Offset? _startOffset;
  SurfaceTransform? _startTransform;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        setState(() {
          _moving = _hitTest(event.localPosition);
          _startOffset = event.localPosition;
          _startTransform = widget.transform;
        });
      },
      onPointerCancel: (event) {
        setState(() {
          _moving = HandleHitTest(false, false, false, false);
          _startOffset = null;
        });
      },
      onPointerUp: (event) {
        setState(() {
          _moving = HandleHitTest(false, false, false, false);
          _startOffset = null;
        });
        widget.onConfirm!();
      },
      onPointerMove: (event) {
        if (_moving.hit && _startOffset != null) {
          var movement = event.localPosition - _startOffset!;

          var size = (context.findRenderObject() as RenderBox).size;
          var screenSize = PADDING.deflateSize(size);

          var topLeftOffset = _point(_startTransform!.topLeft, screenSize);
          var topRightOffset = _point(_startTransform!.topRight, screenSize);
          var bottomLeftOffset = _point(_startTransform!.bottomLeft, screenSize);
          var bottomRightOffset = _point(_startTransform!.bottomRight, screenSize);

          var topLeft = _moving.topLeftHit ? topLeftOffset + movement : topLeftOffset;
          var topRight = _moving.topRightHit ? topRightOffset + movement : topRightOffset;
          var bottomLeft = _moving.bottomLeftHit ? bottomLeftOffset + movement : bottomLeftOffset;
          var bottomRight =
              _moving.bottomRightHit ? bottomRightOffset + movement : bottomRightOffset;

          var topLeftPoint = SurfaceTransformPoint(
              x: (topLeft.dx / screenSize.width).clamp(0, 1),
              y: (topLeft.dy / screenSize.height).clamp(0, 1));
          var topRightPoint = SurfaceTransformPoint(
              x: (topRight.dx / screenSize.width).clamp(0, 1),
              y: (topRight.dy / screenSize.height).clamp(0, 1));
          var bottomLeftPoint = SurfaceTransformPoint(
              x: (bottomLeft.dx / screenSize.width).clamp(0, 1),
              y: (bottomLeft.dy / screenSize.height).clamp(0, 1));
          var bottomRightPoint = SurfaceTransformPoint(
              x: (bottomRight.dx / screenSize.width).clamp(0, 1),
              y: (bottomRight.dy / screenSize.height).clamp(0, 1));

          widget.onChange!(SurfaceTransform(
              topLeft: topLeftPoint,
              topRight: topRightPoint,
              bottomLeft: bottomLeftPoint,
              bottomRight: bottomRightPoint));
        }
      },
      onPointerHover: (event) {
        setState(() {
          _hover = _hitTest(event.localPosition);
        });
      },
      child: MouseRegion(
        cursor: _hover.hit ? SystemMouseCursors.move : SystemMouseCursors.basic,
        child: Padding(
          padding: PADDING,
          child: CustomPaint(
            painter: MappingPainter(widget.transform, _hover),
          ),
        ),
      ),
    );
  }

  HandleHitTest _hitTest(Offset position) {
    var size = (context.findRenderObject() as RenderBox).size;
    var screenSize = PADDING.deflateSize(size);

    var topLeft = _point(widget.transform.topLeft, screenSize).translate(8, 8);
    var topRight = _point(widget.transform.topRight, screenSize).translate(8, 8);
    var bottomLeft = _point(widget.transform.bottomLeft, screenSize).translate(8, 8);
    var bottomRight = _point(widget.transform.bottomRight, screenSize).translate(8, 8);

    var topLeftHandle = Rect.fromCenter(center: topLeft, width: HANDLE_SIZE, height: HANDLE_SIZE);
    var topRightHandle = Rect.fromCenter(center: topRight, width: HANDLE_SIZE, height: HANDLE_SIZE);
    var bottomLeftHandle =
        Rect.fromCenter(center: bottomLeft, width: HANDLE_SIZE, height: HANDLE_SIZE);
    var bottomRightHandle =
        Rect.fromCenter(center: bottomRight, width: HANDLE_SIZE, height: HANDLE_SIZE);

    var topLeftHit = topLeftHandle.contains(position);
    var topRightHit = topRightHandle.contains(position);
    var bottomLeftHit = bottomLeftHandle.contains(position);
    var bottomRightHit = bottomRightHandle.contains(position);

    return HandleHitTest(topLeftHit, topRightHit, bottomLeftHit, bottomRightHit);
  }
}

class HandleHitTest {
  bool topLeftHit = false;
  bool topRightHit = false;
  bool bottomLeftHit = false;
  bool bottomRightHit = false;

  HandleHitTest(this.topLeftHit, this.topRightHit, this.bottomLeftHit, this.bottomRightHit);

  bool get hit => topLeftHit || topRightHit || bottomLeftHit || bottomRightHit;
}

class MappingPainter extends CustomPainter {
  final SurfaceTransform transform;
  final Offset? pointer;
  final HandleHitTest _hover;

  MappingPainter(this.transform, this._hover, {this.pointer});

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawMapping(canvas, size);
  }

  void _drawBackground(Canvas canvas, Size size) {
    final border = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final fill = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, border);
    canvas.drawRect(rect, fill);
  }

  void _drawMapping(Canvas canvas, Size size) {
    var topLeft = _point(transform.topLeft, size);
    var topRight = _point(transform.topRight, size);
    var bottomLeft = _point(transform.bottomLeft, size);
    var bottomRight = _point(transform.bottomRight, size);

    final border = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final fill = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..close();

    canvas.drawPath(path, border);
    canvas.drawPath(path, fill);

    _drawHandle(canvas, topLeft, _hover.topLeftHit);
    _drawHandle(canvas, topRight, _hover.topRightHit);
    _drawHandle(canvas, bottomLeft, _hover.bottomLeftHit);
    _drawHandle(canvas, bottomRight, _hover.bottomRightHit);
  }

  void _drawHandle(Canvas canvas, Offset offset, bool hover) {
    final border = Paint()
      ..color = hover ? Colors.deepOrange : Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final fill = Paint()
      ..color = hover ? Colors.deepOrange.withOpacity(0.7) : Colors.white70
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(center: offset, width: HANDLE_SIZE, height: HANDLE_SIZE);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(2));

    canvas.drawRRect(rrect, border);
    canvas.drawRRect(rrect, fill);
  }

  @override
  bool shouldRepaint(covariant MappingPainter oldDelegate) {
    return oldDelegate._hover != _hover || oldDelegate.transform != transform;
  }
}

Offset _point(SurfaceTransformPoint point, Size size) {
  return Offset(point.x * size.width, point.y * size.height);
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

const double FRAME_EDITOR_CHANNEL_HEIGHT = 80;

class EffectsView extends StatefulWidget {
  const EffectsView({Key? key}) : super(key: key);

  @override
  State<EffectsView> createState() => _EffectsViewState();
}

class _EffectsViewState extends State<EffectsView> {
  Effect? effect;

  @override
  Widget build(BuildContext context) {
    EffectsBloc bloc = context.read();
    return BlocBuilder<EffectsBloc, EffectState>(
        builder: (context, effects) {
          return Column(
            children: [
              Expanded(
                child: Panel(
                  label: "Effects".i18n,
                  child: MizerTable(
                    columns: [
                      Text("ID"),
                      Text("Name"),
                    ],
                    columnWidths: {
                      0: FixedColumnWidth(64),
                    },
                    rows: effects.map((e) => MizerTableRow(cells: [
                      Text(e.id.toString()),
                      Text(e.name),
                    ], onTap: () => setState(() => this.effect = e),
                      selected: this.effect == e
                    )).toList(),
                  ),
                  actions: [
                    PanelAction(label: "Add Effect".i18n),
                    PanelAction(label: "Delete".i18n, disabled: this.effect == null, onClick: () => bloc.add(DeleteEffect(effect!.id))),
                  ],
                ),
              ),
              if (effect != null) Expanded(child: EffectEditor(effect: effect!))
            ],
          );
        });
  }
}

class EffectEditor extends StatelessWidget {
  final Effect effect;

  const EffectEditor({Key? key, required this.effect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            height: 332,
            child: MovementEditor(effect: effect),
          ),
          Expanded(child: FrameEditor(effect: effect))
        ]);
  }
}

class FrameEditor extends StatelessWidget {
  final Effect effect;

  const FrameEditor({required this.effect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
        label: "Frames".i18n,
        child: ListView(
          children: effect.channels.map((channel) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                SizedBox(child: Text(channel.control.name), width: 128),
                Padding(padding: const EdgeInsets.all(8)),
                Expanded(
                    child: CustomPaint(painter: FramePainter(channel), size: Size.fromHeight(64)))
              ]),
            );
          }).toList(growable: false),
        ));
  }
}

class FrameChannelEditor extends StatelessWidget {
  final EffectChannel channel;

  const FrameChannelEditor(this.channel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: FramePainter(channel), size: Size.fromHeight(FRAME_EDITOR_CHANNEL_HEIGHT));
  }
}

class FramePainter extends CustomPainter {
  final EffectChannel channel;

  FramePainter(this.channel);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1 * size.height, -1 * size.height);
    var axisWidth = size.height;
    _drawAxis(canvas, axisWidth);
    _drawSecondaryAxis(canvas, axisWidth);
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = Color(0x11ffffff)
      ..style = PaintingStyle.fill;
    var upperLinePath = Path();
    var lowerLinePath = Path();
    var fillPath = Path();
    var backPath = [];
    var lastPoint = Offset(0, 0);
    for (var i = 0; i < channel.steps.length; i++) {
      var step = channel.steps[i];
      var offset = (i - 1).clamp(0, channel.steps.length);
      double x = i.toDouble();
      double y;
      double y2;
      if (step.value.hasRange()) {
        y = step.value.range.from;
        y2 = step.value.range.to;
      } else {
        y = step.value.direct;
        y2 = y;
      }
      if (i == 0) {
        upperLinePath.moveTo(x, y);
        lowerLinePath.moveTo(x, y2);
      }
      if (step.hasCubic()) {
        upperLinePath.cubicTo(
            offset + step.cubic.c0a, step.cubic.c0b, offset + step.cubic.c1a, step.cubic.c1b, x, y);
        lowerLinePath.cubicTo(offset + step.cubic.c0a, step.cubic.c0b, offset + step.cubic.c1a,
            step.cubic.c1b, x, y2);
        _drawHandle(
            canvas, lastPoint.dx, lastPoint.dy, offset + step.cubic.c0a, step.cubic.c0b, false);
        _drawHandle(canvas, x, y, offset + step.cubic.c1a, step.cubic.c1b, false);
      } else if (step.hasQuadratic()) {
        upperLinePath.quadraticBezierTo(step.quadratic.c0a, step.quadratic.c0b, x, y);
        lowerLinePath.quadraticBezierTo(step.quadratic.c0a, step.quadratic.c0b, x, y2);
      } else {
        upperLinePath.lineTo(x, y);
        lowerLinePath.lineTo(x, y2);
      }
      fillPath.lineTo(x, y);
      backPath.add([x, y2]);
      lastPoint = Offset(x, y);
    }
    for (var step in backPath.reversed) {
      fillPath.lineTo(step[0], step[1]);
    }
    canvas.drawPath(upperLinePath, linePaint);
    canvas.drawPath(lowerLinePath, linePaint);
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant FramePainter oldDelegate) {
    return oldDelegate.channel != channel;
  }

  void _drawHandle(Canvas canvas, double x0, double y0, double x1, double y1, bool hit) {
    Paint pathPaint = Paint()
      ..color = Color(0xaaffffff)
      ..style = PaintingStyle.stroke;
    Paint handlePaint = Paint()
      ..color = hit ? Colors.red : Color(0xffffffff)
      ..style = PaintingStyle.fill;
    var handle = Path()
      ..moveTo(x0, y0)
      ..lineTo(x1, y1);
    canvas.drawPath(handle, pathPaint);
    canvas.drawCircle(Offset(x1, y1), hit ? 0.03 : 0.02, handlePaint);
  }

  void _drawAxis(Canvas canvas, double width) {
    Paint axisPaint = Paint()
      ..color = Color(0x55ffffff)
      ..style = PaintingStyle.stroke;
    var xAxis = Path()
      ..moveTo(0, 0.0)
      ..lineTo(width, 0.0);
    var yAxis = Path()
      ..moveTo(0.0, 0)
      ..lineTo(0.0, 1);
    canvas.drawPath(xAxis, axisPaint);
    canvas.drawPath(yAxis, axisPaint);
  }

  void _drawSecondaryAxis(Canvas canvas, double width) {
    Paint axisPaint = Paint()
      ..color = Color(0x22ffffff)
      ..style = PaintingStyle.stroke;
    for (double i = 1; i < width; i++) {
      var path = Path()
        ..moveTo(i, 0)
        ..lineTo(i, 1);
      canvas.drawPath(path, axisPaint);
    }
  }
}

class MovementEditor extends StatelessWidget {
  final Effect effect;

  const MovementEditor({required this.effect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pan = effect.channels.firstWhereOrNull((element) => element.control == FixtureControl.PAN);
    var tilt = effect.channels.firstWhereOrNull((element) => element.control == FixtureControl.TILT);

    return Panel(
        label: "Movement".i18n,
        child: CustomPaint(painter: MovementPainter(pan, tilt), size: Size.infinite));
  }
}

class MovementPainter extends CustomPainter {
  final EffectChannel? pan;
  final EffectChannel? tilt;

  MovementPainter(this.pan, this.tilt);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1 * size.height, -1 * size.height);
    _drawAxis(canvas);
    _drawSecondaryAxis(canvas);
    if (pan != null && tilt != null) {
      _drawMovement(canvas);
    }
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
    var pan = this.pan!;
    var tilt = this.tilt!;
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    var path = Path();
    for (var i = 0; i < pan.steps.length; i++) {
      var panStep = pan.steps[i];
      var tiltStep = tilt.steps[i];
      double x = panStep.value.direct;
      double y = tiltStep.value.direct;
      if (i == 0) {
        path.moveTo(x, y);
      }
      if (panStep.hasSimple()) {
        path.lineTo(x, y);
      }else if (panStep.hasCubic()) {
        double x1 = (panStep.cubic.c0a + tiltStep.cubic.c0a) / 2;
        double y1 = (panStep.cubic.c0b + tiltStep.cubic.c0b) / 2;
        double x2 = (panStep.cubic.c1a + tiltStep.cubic.c1a) / 2;
        double y2 = (panStep.cubic.c1b + tiltStep.cubic.c1b) / 2;
        path.cubicTo(x1, y1, x2, y2, x, y);
      }
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

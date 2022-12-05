import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:widgetbook/widgetbook.dart';

import 'effect_editor.dart';
import 'frame_editor.dart';
import 'movement_editor.dart';

WidgetbookFolder effectsViewWidgets() {
  return WidgetbookFolder(name: "Effects View", widgets: [
    WidgetbookComponent(name: '$EffectEditor', useCases: [
      WidgetbookUseCase(
          name: 'Square',
          builder: (context) => EffectEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.PAN, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                  ]),
                  EffectChannel(control: FixtureControl.TILT, steps: [
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Circle',
          builder: (context) => EffectEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.PAN, steps: [
                    EffectStep(value: CueValue(direct: 0.5), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(
                            c0a: 0.275957512247, c0b: 1, c1a: 1, c1b: 0.275957512247)),
                    EffectStep(
                        value: CueValue(direct: 0.5),
                        cubic: CubicControlPoint(
                            c0a: 0.275957512247, c0b: 0, c1a: 1, c1b: 0.275957512247)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(
                            c0a: 0, c0b: 0.275957512247, c1a: 0.275957512247, c1b: 0)),
                    EffectStep(
                        value: CueValue(direct: 0.5),
                        cubic: CubicControlPoint(
                            c0a: 1, c0b: 0.275957512247, c1a: 0.275957512247, c1b: 1)),
                  ]),
                  EffectChannel(control: FixtureControl.TILT, steps: [
                    EffectStep(value: CueValue(direct: 0.5), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(
                            c0a: 1, c0b: 0.275957512247, c1a: 0.275957512247, c1b: 1)),
                    EffectStep(
                        value: CueValue(direct: 0.5),
                        cubic: CubicControlPoint(
                            c0a: 0.275957512247, c0b: 1, c1a: 1, c1b: 0.275957512247)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(
                            c0a: 0.275957512247, c0b: 0, c1a: 0, c1b: 0.275957512247)),
                    EffectStep(
                        value: CueValue(direct: 0.5),
                        cubic: CubicControlPoint(
                            c0a: 0, c0b: 0.275957512247, c1a: 0.275957512247, c1b: 0)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
    ]),
    WidgetbookComponent(name: '$FrameEditor', useCases: [
      WidgetbookUseCase(
          name: 'Simple',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Saw',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: 0.5, c0b: 0.5, c1a: 0.5, c1b: 0.5)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(c0a: 0.5, c0b: 0.5, c1a: 0.5, c1b: 0.5)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Combination',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(c0a: 0.5, c0b: 0.5, c1a: 0.5, c1b: 0.5)),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: 0.45, c0b: 0.05, c1a: 0.55, c1b: 0.95)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(c0a: .46, c0b: .03, c1a: .52, c1b: .96)),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .65, c0b: .05, c1a: .36, c1b: 1)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(c0a: .77, c0b: 0, c1a: .18, c1b: 1)),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .86, c0b: 0, c1a: .07, c1b: 1)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(c0a: 1, c0b: 0, c1a: 0, c1b: 1)),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .79, c0b: .14, c1a: .15, c1b: .86)),
                    EffectStep(
                        value: CueValue(direct: 0),
                        cubic: CubicControlPoint(c0a: .68, c0b: -0.55, c1a: .27, c1b: 1.55)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Line',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: 0.5, c0b: 0.5, c1a: 0.5, c1b: 0.5)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Sine',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: 0.45, c0b: 0.05, c1a: 0.55, c1b: 0.95)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Quadratic',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .46, c0b: .03, c1a: .52, c1b: .96)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Cubic',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .65, c0b: .05, c1a: .36, c1b: 1)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Quartic',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .77, c0b: 0, c1a: .18, c1b: 1)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Quintic',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .86, c0b: 0, c1a: .07, c1b: 1)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Exponential',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: 1, c0b: 0, c1a: 0, c1b: 1)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Circular',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .79, c0b: .14, c1a: .15, c1b: .86)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Backward',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.INTENSITY, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(
                        value: CueValue(direct: 1),
                        cubic: CubicControlPoint(c0a: .68, c0b: -0.55, c1a: .27, c1b: 1.55)),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
      WidgetbookUseCase(
          name: 'Square',
          builder: (context) => FrameEditor(
                effect: Effect(channels: [
                  EffectChannel(control: FixtureControl.PAN, steps: [
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                  ]),
                  EffectChannel(control: FixtureControl.TILT, steps: [
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                    EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                  ])
                ]),
                onUpdateStepValue: (int channelIndex, int stepIndex, double y) {},
                onUpdateStepCubicPosition:
                    (int channelIndex, int stepIndex, bool first, double x, double y) {},
                onFinishInteraction: (int channelIndex, int stepIndex) {},
              )),
    ]),
    WidgetbookComponent(name: '$MovementEditor', useCases: [
      WidgetbookUseCase(
          name: 'Square',
          builder: (context) => MovementEditor(
                  effect: Effect(channels: [
                EffectChannel(control: FixtureControl.PAN, steps: [
                  EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                  EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                  EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                  EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                ]),
                EffectChannel(control: FixtureControl.TILT, steps: [
                  EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                  EffectStep(value: CueValue(direct: 1), simple: SimpleControlPoint()),
                  EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                  EffectStep(value: CueValue(direct: 0), simple: SimpleControlPoint()),
                ])
              ])))
    ]),
    WidgetbookComponent(name: 'SplinePainter', useCases: [
      WidgetbookUseCase(
          name: 'Line', builder: (context) => InteractiveSplineWidget(0.5, 0.5, 0.5, 0.5)),
      WidgetbookUseCase(
          name: 'Sine', builder: (context) => InteractiveSplineWidget(.45, .05, .55, .95)),
      WidgetbookUseCase(
          name: 'Quadratic', builder: (context) => InteractiveSplineWidget(.46, .03, .52, .96)),
      WidgetbookUseCase(
          name: 'Cubic', builder: (context) => InteractiveSplineWidget(.65, .05, .36, 1)),
      WidgetbookUseCase(
          name: 'Quartic', builder: (context) => InteractiveSplineWidget(.77, 0, .18, 1)),
      WidgetbookUseCase(
          name: 'Quintic', builder: (context) => InteractiveSplineWidget(.86, 0, .07, 1)),
      WidgetbookUseCase(
          name: 'Exponential', builder: (context) => InteractiveSplineWidget(1, 0, 0, 1)),
      WidgetbookUseCase(
          name: 'Circular', builder: (context) => InteractiveSplineWidget(.79, .14, .15, .86)),
      WidgetbookUseCase(
          name: 'Backward', builder: (context) => InteractiveSplineWidget(.68, -0.55, .27, 1.55)),
    ]),
  ]);
}

class InteractiveSplineWidget extends StatefulWidget {
  final double x0;
  final double y0;
  final double x1;
  final double y1;

  const InteractiveSplineWidget(this.x0, this.y0, this.x1, this.y1, {Key? key}) : super(key: key);

  @override
  State<InteractiveSplineWidget> createState() => _InteractiveSplineWidgetState();
}

class _InteractiveSplineWidgetState extends State<InteractiveSplineWidget> {
  bool point0Hit = false;
  bool move0 = false;
  bool point1Hit = false;
  bool move1 = false;
  late double x0;
  late double y0;
  late double x1;
  late double y1;

  @override
  void initState() {
    super.initState();
    x0 = widget.x0;
    y0 = widget.y0;
    x1 = widget.x1;
    y1 = widget.y1;
  }

  @override
  void didUpdateWidget(InteractiveSplineWidget oldWidget) {
    x0 = widget.x0;
    y0 = widget.y0;
    x1 = widget.x1;
    y1 = widget.y1;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerHover: (event) {
        setState(() {
          point0Hit = hit0(event.localPosition);
          point1Hit = hit1(event.localPosition);
        });
      },
      onPointerDown: (event) {
        if (hit0(event.localPosition)) {
          setState(() {
            move0 = true;
            move1 = false;
          });
        }
        if (hit1(event.localPosition)) {
          setState(() {
            move0 = false;
            move1 = true;
          });
        }
      },
      onPointerUp: (_) {
        setState(() {
          move0 = false;
          move1 = false;
        });
      },
      onPointerMove: (event) {
        double x = event.localPosition.dx / 100;
        double y = (100 - event.localPosition.dy) / 100;
        if (move0) {
          setState(() {
            x0 = x;
            y0 = y;
          });
        }
        if (move1) {
          setState(() {
            x1 = x;
            y1 = y;
          });
        }
      },
      child: CustomPaint(
          painter: SplinePainter(x0, y0, x1, y1, point0Hit, point1Hit),
          child: Container(width: 100, height: 100)),
    );
  }

  bool hit0(Offset position) {
    double x = position.dx / 100;
    double y = (100 - position.dy) / 100;
    return hitTest(x0, y0, x, y);
  }

  bool hit1(Offset position) {
    double x = position.dx / 100;
    double y = (100 - position.dy) / 100;
    return hitTest(x1, y1, x, y);
  }
}

class SplinePainter extends CustomPainter {
  double x0;
  double y0;
  double x1;
  double y1;
  bool point0Hit;
  bool point1Hit;

  SplinePainter(this.x0, this.y0, this.x1, this.y1, this.point0Hit, this.point1Hit);

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.01;
    canvas.translate(0, size.height);
    canvas.scale(1 * size.width, -1 * size.height);
    var path = Path()
      ..moveTo(0, 0)
      ..cubicTo(x0, y0, x1, y1, 1, 1);
    canvas.drawPath(path, linePaint);

    _drawHandle(canvas, 0, 0, x0, y0, point0Hit);
    _drawHandle(canvas, 1, 1, x1, y1, point1Hit);

    var point0 = fromPoint(x0, y0);
    var point1 = fromPoint(x1, y1);
    Paint pathPaint = Paint()
      ..color = Color(0xaaffffff)
      ..style = PaintingStyle.stroke;
    canvas.drawRect(point0, pathPaint);
    canvas.drawRect(point1, pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
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
}

bool hitTest(double x0, double y0, double x1, double y1) {
  bool hitX = x0 - 0.1 <= x1 && x0 + 0.1 >= x1;
  bool hitY = y0 - 0.1 <= y1 && y0 + 0.1 >= y1;
  log("$x0 $x1 $hitX");
  log("$y0 $y1 $hitY");

  return hitX && hitY;
}

Rect fromPoint(double x, double y) {
  return Rect.fromCenter(center: Offset(x, y), width: 0.1, height: 0.1);
}

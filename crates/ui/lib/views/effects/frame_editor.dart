import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/effects.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/extensions/fixture_fader_control_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/panel.dart';

import 'frame_painter.dart';

const double FRAME_EDITOR_CHANNEL_HEIGHT = 80;

List<FixtureFaderControl> faderControls = [
  FixtureFaderControl(control: FixtureControl.INTENSITY),
  FixtureFaderControl(control: FixtureControl.SHUTTER),
  FixtureFaderControl(control: FixtureControl.PAN),
  FixtureFaderControl(control: FixtureControl.TILT),
  FixtureFaderControl(control: FixtureControl.FOCUS),
  FixtureFaderControl(control: FixtureControl.ZOOM),
  FixtureFaderControl(control: FixtureControl.PRISM),
  FixtureFaderControl(control: FixtureControl.IRIS),
  FixtureFaderControl(control: FixtureControl.FROST),
  FixtureFaderControl(control: FixtureControl.GOBO),
  FixtureFaderControl(control: FixtureControl.COLOR_WHEEL),
  FixtureFaderControl(
      control: FixtureControl.COLOR_MIXER,
      colorMixerChannel: FixtureFaderControl_ColorMixerControlChannel.RED),
  FixtureFaderControl(
      control: FixtureControl.COLOR_MIXER,
      colorMixerChannel: FixtureFaderControl_ColorMixerControlChannel.GREEN),
  FixtureFaderControl(
      control: FixtureControl.COLOR_MIXER,
      colorMixerChannel: FixtureFaderControl_ColorMixerControlChannel.BLUE),
];

class FrameEditor extends StatelessWidget {
  final Effect effect;
  final Function(int, int, double) onUpdateStepValue;
  final Function(int, int, bool, double, double) onUpdateStepCubicPosition;
  final Function(int, int) onFinishInteraction;
  final Function(int, int) onRemoveStep;
  final Function(int) onRemoveChannel;
  final Function(FixtureFaderControl) onAddChannel;
  final Function(int, EffectStep) onAddStep;

  const FrameEditor(
      {required this.effect,
      required this.onUpdateStepValue,
      required this.onUpdateStepCubicPosition,
      required this.onFinishInteraction,
      required this.onRemoveStep,
      required this.onRemoveChannel,
      required this.onAddChannel,
      required this.onAddStep,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
        label: "Frames".i18n,
        actions: [PanelAction(label: "Add Channel", onClick: () => _addChannel(context))],
        child: ListView(
          children: effect.channels.mapIndexed((channelIndex, channel) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                SizedBox(child: Text(channel.control.name), width: 128),
                MizerIconButton(
                    icon: Icons.close,
                    label: "Remove Channel",
                    onClick: () => onRemoveChannel(channelIndex)),
                Padding(padding: const EdgeInsets.all(8)),
                Expanded(
                    child: FrameChannelEditor(
                  channel,
                  onUpdateStep: (stepIndex, y) => onUpdateStepValue(channelIndex, stepIndex, y),
                  onUpdateStepCubicPosition: (stepIndex, first, x, y) =>
                      onUpdateStepCubicPosition(channelIndex, stepIndex, first, x, y),
                  onFinishInteraction: (stepIndex) => onFinishInteraction(channelIndex, stepIndex),
                  onRemoveStep: (stepIndex) => onRemoveStep(channelIndex, stepIndex),
                  onAddStep: (step) => onAddStep(channelIndex, step),
                )),
              ]),
            );
          }).toList(growable: false),
        ));
  }

  _addChannel(BuildContext context) async {
    FixtureFaderControl? control = await showDialog(
        context: context,
        builder: (context) => ActionDialog(
            title: "Add Channel",
            content: Column(
                children: faderControls
                    .whereNot((faderControl) =>
                        effect.channels.any((channel) => faderControl.control == channel.control))
                    .sortedBy((faderControl) => faderControl.toDisplay())
                    .map((faderControl) => ListTile(
                        title: Text(faderControl.toDisplay()),
                        onTap: () => Navigator.of(context).pop(faderControl)))
                    .toList()),
            actions: [PopupAction("Cancel", () => Navigator.of(context).pop())]));
    if (control == null) {
      return;
    }
    this.onAddChannel(control);
  }
}

class FrameChannelEditor extends StatefulWidget {
  final EffectChannel channel;
  final Function(int, double) onUpdateStep;
  final Function(int, bool, double, double) onUpdateStepCubicPosition;
  final Function(int) onFinishInteraction;
  final Function(int) onRemoveStep;
  final Function(EffectStep) onAddStep;

  const FrameChannelEditor(this.channel,
      {required this.onUpdateStep,
      required this.onUpdateStepCubicPosition,
      required this.onFinishInteraction,
      required this.onRemoveStep,
      required this.onAddStep,
      Key? key})
      : super(key: key);

  @override
  State<FrameChannelEditor> createState() => _FrameChannelEditorState();
}

class _FrameChannelEditorState extends State<FrameChannelEditor> {
  List<PointState> points = [];
  List<HandleState> handles = [];

  @override
  void initState() {
    super.initState();
    _setupPoints();
    _setupHandles();
  }

  @override
  void didUpdateWidget(FrameChannelEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.points.length != widget.channel.steps.length) {
      _setupPoints();
      _setupHandles();
    } else {
      List<PointState> points = _updatePoints();
      List<HandleState> handles = _updateHandles();
      setState(() {
        this.points = points;
        this.handles = handles;
      });
    }
  }

  List<PointState> _updatePoints() {
    var points = this.points.toList();
    for (var i = 0; i < points.length; i++) {
      var step = widget.channel.steps[i];
      points[i].y = step.value.hasDirect() ? step.value.direct : step.value.range.from;
    }
    return points;
  }

  List<HandleState> _updateHandles() {
    var handles = this.handles.toList();
    var handleIndex = 0;
    for (var i = 0; i < widget.channel.steps.length; i++) {
      var step = widget.channel.steps[i];
      if (!step.hasCubic()) {
        continue;
      }
      handles[handleIndex * 2].update(step.cubic);
      handles[handleIndex * 2 + 1].update(step.cubic);
      handleIndex += 1;
    }
    return handles;
  }

  void _setupPoints() {
    setState(() {
      this.points = widget.channel.steps.mapIndexed((i, step) {
        return new PointState(step, i);
      }).toList();
    });
  }

  void _setupHandles() {
    List<HandleState> handles = [];
    for (var i = 0; i < widget.channel.steps.length; i++) {
      var step = widget.channel.steps[i];
      if (!step.hasCubic()) {
        continue;
      }
      var first = HandleState(step, i, true);
      var second = HandleState(step, i, false);

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
          if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
            var hitPoint =
                this.points.firstWhereOrNull((point) => point.isHit(event.localPosition));
            if (hitPoint != null) {
              widget.onRemoveStep(hitPoint.stepIndex);
              return;
            } else {
              double x = event.localPosition.dx / FRAME_EDITOR_CHANNEL_HEIGHT;
              double y = (FRAME_EDITOR_CHANNEL_HEIGHT - event.localPosition.dy) /
                  FRAME_EDITOR_CHANNEL_HEIGHT;

              if (!this.points.any((point) => point.x > x)) {
                var midPoint = ((this.points.lastOrNull?.y ?? 0) - y).abs();
                var value = CueValue(direct: y);
                var step = EffectStep(
                  value: value,
                );
                if (this.points.isEmpty) {
                  step.simple = SimpleControlPoint();
                } else {
                  step.cubic = CubicControlPoint(c0a: 0.5, c0b: midPoint, c1a: 0.5, c1b: midPoint);
                }

                widget.onAddStep(step);
                return;
              }
            }
          }
          List<PointState> points = _findHitPoint(event);
          List<HandleState> handles = _findHitHandle(event);
          setState(() {
            this.points = points;
            this.handles = handles;
          });
        },
        onPointerUp: (_) {
          setState(() {
            for (var point in this.points) {
              if (point.move) {
                widget.onFinishInteraction(point.stepIndex);
              }
              point.move = false;
            }
            for (var handle in this.handles) {
              if (handle.move) {
                widget.onFinishInteraction(handle.stepIndex);
              }
              handle.move = false;
            }
          });
        },
        onPointerMove: (event) {
          double x = event.localPosition.dx / FRAME_EDITOR_CHANNEL_HEIGHT;
          double y =
              (FRAME_EDITOR_CHANNEL_HEIGHT - event.localPosition.dy) / FRAME_EDITOR_CHANNEL_HEIGHT;

          var movingPoint = this.points.firstWhereOrNull((point) => point.move);
          if (movingPoint != null) {
            widget.onUpdateStep(movingPoint.x.toInt(), y.clamp(0, 1));
          }
          var movingHandle = this.handles.firstWhereOrNull((handle) => handle.move);
          if (movingHandle != null) {
            widget.onUpdateStepCubicPosition(movingHandle.stepIndex, movingHandle.first,
                (x - movingHandle.stepIndex + 1), y.clamp(0, 1));
          }
        },
        child: CustomPaint(
            painter: FramePainter(widget.channel, points, handles),
            size: Size.fromHeight(FRAME_EDITOR_CHANNEL_HEIGHT)));
  }

  List<HandleState> _findHitHandle(PointerDownEvent event) {
    var handles = this.handles.map((handle) {
      handle.move = false;
      return handle;
    }).toList();
    var hitHandle = handles.firstWhereOrNull((handle) => handle.isHit(event.localPosition));
    if (hitHandle != null) {
      hitHandle.move = true;
    }
    return handles;
  }

  List<PointState> _findHitPoint(PointerDownEvent event) {
    var points = this.points.map((point) {
      point.move = false;
      return point;
    }).toList();
    var hitPoint = points.firstWhereOrNull((point) => point.isHit(event.localPosition));
    if (hitPoint != null) {
      hitPoint.move = true;
    }
    return points;
  }

  void _hitTestHandles(PointerHoverEvent event) {
    this.handles = this.handles.map((handle) {
      handle.hit = handle.isHit(event.localPosition);
      return handle;
    }).toList();
  }

  void _hitTestPoints(PointerHoverEvent event) {
    this.points = this.points.map((point) {
      point.hit = point.isHit(event.localPosition);
      return point;
    }).toList();
  }
}

class PointState {
  EffectStep step;
  bool hit = false;
  bool move = false;
  double x;
  double y;

  PointState(this.step, int x)
      : y = step.value.hasDirect() ? step.value.direct : step.value.range.from,
        this.x = x.toDouble();

  bool isHit(Offset position) {
    double x = position.dx / FRAME_EDITOR_CHANNEL_HEIGHT;
    double y = (FRAME_EDITOR_CHANNEL_HEIGHT - position.dy) / FRAME_EDITOR_CHANNEL_HEIGHT;

    return hitTest(this.x, this.y, x, y);
  }

  int get stepIndex {
    return x.toInt();
  }

  @override
  String toString() {
    return 'PointState{hit: $hit, move: $move, x: $x, y: $y}';
  }
}

class HandleState {
  int stepIndex;
  EffectStep step;
  bool hit = false;
  bool move = false;
  double x;
  double y;
  bool first;

  HandleState(this.step, this.stepIndex, this.first)
      : y = (first ? step.cubic.c1b : step.cubic.c0b),
        x = (stepIndex - 1) + (first ? step.cubic.c1a : step.cubic.c0a);

  bool isHit(Offset position) {
    double x = position.dx / FRAME_EDITOR_CHANNEL_HEIGHT;
    double y = (FRAME_EDITOR_CHANNEL_HEIGHT - position.dy) / FRAME_EDITOR_CHANNEL_HEIGHT;

    return hitTest(this.x, this.y, x, y);
  }

  void update(CubicControlPoint cubic) {
    y = (first ? cubic.c1b : cubic.c0b);
    x = (stepIndex - 1) + (first ? cubic.c1a : cubic.c0a);
  }

  @override
  String toString() {
    return 'HandleState{stepIndex: $stepIndex, step: $step, hit: $hit, move: $move, x: $x, y: $y, first: $first}';
  }
}

const delta = 0.05;

bool hitTest(double x0, double y0, double x1, double y1) {
  bool hitX = x0 - delta <= x1 && x0 + delta >= x1;
  bool hitY = y0 - delta <= y1 && y0 + delta >= y1;

  return hitX && hitY;
}

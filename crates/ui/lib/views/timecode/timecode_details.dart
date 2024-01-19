import 'package:flutter/material.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';
import 'package:mizer/protos/timecode.pb.dart';
import 'package:mizer/state/timecode_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/spline_field.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/splines/handle_state.dart';
import 'package:mizer/widgets/splines/point_state.dart';
import 'package:mizer/widgets/splines/spline_editor.dart';
import 'package:provider/provider.dart';

import 'consts.dart';
import 'dialogs/add_timecode_control_dialog.dart';
import 'editor/timecode_playback_handle.dart';
import 'editor/timecode_strip.dart';

class TimecodeDetail extends StatelessWidget {
  final Timecode timecode;
  final List<TimecodeControl> controls;
  final TimecodeReader? reader;

  const TimecodeDetail({required this.timecode, required this.controls, Key? key, this.reader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: timecode.name,
      actions: [
        PanelActionModel(label: "Add Control", onClick: () => _addTimecodeControl(context))
      ],
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: titleRowHeight,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: firstColumnWidth, child: Container()),
                      Expanded(child: TimecodeStrip()),
                    ]),
              ),
              ...timecode.controls.map((control) {
                var c = controls.firstWhere((c) => c.id == control.controlId);
                return Container(
                    height: rowHeight,
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(width: firstColumnWidth, child: Text(c.name)),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          var steps = control.steps.map((e) => TimecodeControlValues_Step()
                              ..x = e.x * pixelsPerSecond
                              ..y = e.y
                              ..c0a = e.c0a * pixelsPerSecond
                              ..c0b = e.c0b
                              ..c1a = e.c1a * pixelsPerSecond
                              ..c1b = e.c1b).toList();
                          return SplineEditor<TimecodeControlValues_Step,
                            TimecodePointState, TimecodeHandleState>(
                          points: steps,
                          builder: (context, points, handles) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: CustomPaint(
                              painter: SplineFieldPainter(steps, points, handles, square: false),
                              size: Size(rowHeight, constraints.maxWidth),
                            ),
                          ),
                          createPoint: (step, index) => TimecodePointState(step, index),
                          createHandle: (step, index, first) => TimecodeHandleState(step, first, index),
                          onAddPoint: (_, x, y) {},
                          onRemovePoint: (_) {},
                          onFinishInteraction: ({point, handle}) {},
                          onUpdateHandle: (_, x, y) {},
                          onUpdatePoint: (_, x, y) {},
                          translatePosition: (position) {
                            double x = position.dx;
                            double y = (rowHeight - position.dy) / rowHeight;

                            return Offset(x, y);
                          },
                        );
                        },
                      )
                    ]));
              })
            ],
          ),
          Positioned(left: 0, right: 0, top: 0, bottom: 0, child: TimecodePlaybackIndicator(reader: reader)),
        ],
      ),
    );
  }

  Future<void> _addTimecodeControl(BuildContext context) async {
    String? name =
        await showDialog(context: context, builder: (context) => new AddTimecodeControlDialog());
    if (name == null) {
      return;
    }
    TimecodeBloc bloc = context.read();
    bloc.addTimecodeControl(name);
  }
}

class TimecodePointState extends PointState<TimecodeControlValues_Step> {
  final int index;

  TimecodePointState(TimecodeControlValues_Step data, this.index)
      : super(data, data.x, data.y, 0.05);

  @override
  void update(TimecodeControlValues_Step data) {
    this.x = data.x;
    this.y = data.y;
  }
}

class TimecodeHandleState extends HandleState<TimecodeControlValues_Step> {
  final int pointIndex;

  TimecodeHandleState(TimecodeControlValues_Step data, bool first, this.pointIndex)
      : super(data, first ? data.c0a : data.c1a, first ? data.c0b : data.c1b, first, 0.05);

  @override
  void update(TimecodeControlValues_Step data) {
    this.x = this.first ? data.c0a : data.c1a;
    this.y = this.first ? data.c0b : data.c1b;
  }
}

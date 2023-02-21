import 'package:flutter/material.dart';
import 'package:mizer/protos/timecode.pb.dart';
import 'package:mizer/state/timecode_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/properties/fields/spline_field.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/splines/handle_state.dart';
import 'package:mizer/widgets/splines/point_state.dart';
import 'package:mizer/widgets/splines/spline_editor.dart';
import 'package:provider/provider.dart';

import 'dialogs/add_timecode_control_dialog.dart';

const double firstColumnWidth = 128;
const double firstRowHeight = 32;
const double rowHeight = 48;

class TimecodeDetail extends StatelessWidget {
  final Timecode timecode;
  final List<TimecodeControl> controls;

  const TimecodeDetail({required this.timecode, required this.controls, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: timecode.name,
      actions: [PanelAction(label: "Add Control", onClick: () => _addTimecodeControl(context))],
      child: InteractiveViewer(
        scaleEnabled: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: firstRowHeight,
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
                  Container(
                      width: firstColumnWidth,
                      child: Text(c.name)),
                  LayoutBuilder(
                    builder: (context, constraints) => SplineEditor<TimecodeControlValues_Step,
                        TimecodePointState, TimecodeHandleState>(
                      points: control.steps,
                      builder: (context, points, handles) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomPaint(
                            painter: SplineFieldPainter(control.steps, points, handles),
                            size: Size(rowHeight, constraints.maxWidth),
                          )),
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
                    ),
                  )
                ]));
            })
          ],
        ),
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

class TimecodeStrip extends StatelessWidget {
  const TimecodeStrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("00:00:00");
    // return CustomPaint(painter: TimecodeStripPainter());
  }
}

class TimecodeStripPainter extends CustomPainter {
  final TextPainter textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter textPainter = TextPainter(text: new TextSpan(text: "00:00:00"));
    textPainter.layout(maxWidth: size.width);
    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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

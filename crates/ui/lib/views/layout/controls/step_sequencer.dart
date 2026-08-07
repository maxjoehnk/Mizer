import 'package:collection/collection.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/inputs/button.dart';
import 'package:provider/provider.dart';

class StepSequencerControl extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;
  final ControlSize? size;

  const StepSequencerControl(
      {required this.pointer,
      required this.control,
      required this.color,
      this.size,
      Key? key})
      : super(key: key);

  @override
  _StepSequencerControlState createState() => _StepSequencerControlState();
}

class _StepSequencerControlState extends State<StepSequencerControl> with SingleTickerProviderStateMixin {
  List<bool> value = List.filled(16, false);
  int beat = 0;
  Color? color;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      var v = widget.pointer.readStepSequencerValue(widget.control.node.path);
      if (!this.mounted) {
        return;
      }
      setState(() {
        value = v.values;
        beat = v.beat;
      });
    });
    this.ticker.start();
  }

  @override
  void dispose() {
    this.ticker.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NodesApi apiClient = context.read();

    return Row(children: value.mapIndexed((i, v) {
          var controlColor = (color ?? widget.color ?? Grey700);
          if (i % 4 == 0) {
            controlColor = controlColor.withRed((controlColor.red8bit + 10).clamp(0, 255));
            controlColor = controlColor.withGreen((controlColor.green8bit + 10).clamp(0, 255));
            controlColor = controlColor.withBlue((controlColor.blue8bit + 10).clamp(0, 255));
          }
          if (i == beat) {
            controlColor = controlColor.withRed((controlColor.red8bit - 20).clamp(0, 255));
            controlColor = controlColor.withGreen((controlColor.green8bit - 20).clamp(0, 255));
            controlColor = controlColor.withBlue((controlColor.blue8bit - 20).clamp(0, 255));
          }

          return ButtonInput(
            label: (i + 1).toString(),
            color: controlColor,
            pressed: v,
            width: 1,
            height: 1,
            onValue: (v) {
              if (v == 0) {
                return;
              }
              List<bool> newValue = this.value;
              newValue[i] = !newValue[i];
              apiClient.updateNodeSetting(UpdateNodeSettingRequest(
                  path: widget.control.node.path,
                  setting: NodeSetting(
                    id: "Steps",
                    stepSequencerValue: NodeSetting_StepSequencerValue(steps: newValue),
                  )));
            },
          );
        }).toList(),
        spacing: GRID_GAP_SIZE);
  }
}

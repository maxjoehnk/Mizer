import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/inputs/encoder.dart';
import 'package:provider/provider.dart';

class DialControl extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;

  const DialControl({required this.pointer, required this.control, required this.color, Key? key})
      : super(key: key);

  @override
  _DialControlState createState() => _DialControlState();
}

class _DialControlState extends State<DialControl> with SingleTickerProviderStateMixin {
  double value = 0;
  double min = 0;
  double max = 1;
  bool isPercentage = true;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      var v = widget.pointer.readDialValue(widget.control.node.path);
      if (!this.mounted) {
        return;
      }
      setState(() {
        value = v.value;
        min = v.min;
        max = v.max;
        isPercentage = v.is_percentage == 1;
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

    return EncoderInput(
      label: widget.control.label,
      color: widget.color,
      value: value,
      maxValue: max,
      percentage: isPercentage,
      onValue: (value) =>
          apiClient.writeControlValue(path: widget.control.node.path, port: "Input", value: value),
    );
  }
}

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/inputs/button.dart';
import 'package:provider/provider.dart';

class ButtonControl extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;

  const ButtonControl({required this.pointer, required this.control, required this.color, Key? key}) : super(key: key);

  @override
  _ButtonControlState createState() => _ButtonControlState();
}

class _ButtonControlState extends State<ButtonControl> with SingleTickerProviderStateMixin {
  double value = 0;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      var v = widget.pointer.readFaderValue(widget.control.node);
      if (!this.mounted) {
        return;
      }
      setState(() => value = v);
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

    return ButtonInput(
      label: widget.control.label,
      color: widget.color,
      pressed: value > 0,
      onValue: (value) =>
          apiClient.writeControlValue(path: widget.control.node, port: "value", value: value),
    );
  }
}

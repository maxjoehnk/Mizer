import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/inputs/fader.dart';
import 'package:provider/provider.dart';

class FaderControl extends StatefulWidget {
  final LayoutControl control;
  final Color? color;

  const FaderControl({required this.control, required this.color, Key? key}) : super(key: key);

  @override
  _FaderControlState createState() => _FaderControlState();
}

class _FaderControlState extends State<FaderControl> with SingleTickerProviderStateMixin {
  double value = 0;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      LayoutsApi apiClient = context.read();
      var v = await apiClient.readFaderValue(widget.control.node);
      if (!this.mounted) {
        return;
      }
      setState(() => value = v);
    });
    this.ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    NodesApi apiClient = context.read();

    return FaderInput(
      label: widget.control.label,
      color: widget.color,
      value: value,
      onValue: (value) =>
          apiClient.writeControlValue(path: widget.control.node, port: "value", value: value),
    );
  }

  @override
  void dispose() {
    this.ticker.stop(canceled: true);
    super.dispose();
  }
}

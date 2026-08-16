import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/inputs/level.dart';

class LevelControl extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;

  const LevelControl({required this.pointer, required this.control, required this.color, Key? key})
      : super(key: key);

  @override
  _LevelControlState createState() => _LevelControlState();
}

class _LevelControlState extends State<LevelControl> with SingleTickerProviderStateMixin {
  double value = 0;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      var v = widget.pointer.readLevelValue(widget.control.node.path);
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
    return LevelDisplay(
      color: widget.color,
      value: value,
    );
  }
}

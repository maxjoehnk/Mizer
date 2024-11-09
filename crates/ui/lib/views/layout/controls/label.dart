import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/inputs/decoration.dart';

class LabelControl extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;

  const LabelControl({required this.pointer, required this.control, required this.color, Key? key})
      : super(key: key);

  @override
  _LabelControlState createState() => _LabelControlState();
}

class _LabelControlState extends State<LabelControl> with SingleTickerProviderStateMixin {
  String value = "";
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      var v = widget.pointer.readLabelValue(widget.control.node.path);
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
    return Container(
        child: Center(
            child: AutoSizeText(value,
                minFontSize: 10,
                wrapWords: false,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!.copyWith(fontSize: 15))),
        decoration: ControlDecoration(color: widget.color ?? Colors.grey.shade900));
  }
}

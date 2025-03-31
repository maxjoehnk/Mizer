import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/inputs/button.dart';
import 'package:provider/provider.dart';

class ButtonControl extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final Color? color;
  final MemoryImage? image;
  final ControlSize? size;

  const ButtonControl(
      {required this.pointer,
      required this.control,
      required this.color,
      required this.image,
      this.size,
      Key? key})
      : super(key: key);

  @override
  _ButtonControlState createState() => _ButtonControlState();
}

class _ButtonControlState extends State<ButtonControl> with SingleTickerProviderStateMixin {
  bool value = false;
  Color? color;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    this.ticker = this.createTicker((elapsed) async {
      var v = widget.pointer.readButtonValue(widget.control.node.path);
      var c = widget.pointer.readControlColor(widget.control.node.path);
      if (!this.mounted) {
        return;
      }
      setState(() {
        value = v;
        color = c?.asFlutterColor;
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

    return ButtonInput(
      label: widget.control.label,
      color: color ?? widget.color,
      image: widget.image,
      pressed: value,
      width: widget.size?.width.toInt(),
      height: widget.size?.height.toInt(),
      onValue: (value) =>
          apiClient.writeControlValue(path: widget.control.node.path, port: "Input", value: value),
    );
  }
}

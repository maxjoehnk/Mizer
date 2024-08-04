import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/plugin/nodes.dart';

class MultiRenderer extends StatefulWidget {
  final NodesPluginApi pluginApi;
  final String path;

  MultiRenderer(this.pluginApi, this.path);

  @override
  State<MultiRenderer> createState() => _MultiRendererState();
}

class _MultiRendererState extends State<MultiRenderer> {
  NodeHistoryPointer? pointer;

  _MultiRendererState();

  @override
  void initState() {
    super.initState();
    _updatePointer();
  }

  @override
  void didUpdateWidget(MultiRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _updatePointer();
    }
  }

  void _updatePointer() {
    widget.pluginApi.getHistoryPointer(widget.path).then((ptr) {
      if (pointer != null) {
        pointer!.dispose();
        pointer = null;
      }
      setState(() {
        pointer = ptr;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (pointer != null) {
      pointer!.dispose();
      pointer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        clipBehavior: Clip.antiAlias,
        child: pointer == null ? Container() : MultiPaint(pointer: pointer!));
  }
}

class MultiPaint extends StatefulWidget {
  final NodeHistoryPointer pointer;

  const MultiPaint({required this.pointer, Key? key}) : super(key: key);

  @override
  State<MultiPaint> createState() => _MultiPaintState();
}

class _MultiPaintState extends State<MultiPaint> with SingleTickerProviderStateMixin {
  List<double> values = [];
  late final Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) => setState(() {
          if (widget.pointer.isDisposed) {
            values = [];
            return;
          }
          values = widget.pointer.readMulti();
        }));
    ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: MultiPainter(values), size: Size(300, 200), willChange: true);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }
}

class MultiPainter extends CustomPainter {
  final List<double> values;

  MultiPainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    double thickness = size.width / values.length;
    Paint paint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.fill;
    Paint backgroundPaint = Paint()
      ..color = Color(0x11ffffff)
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < values.length; i++) {
      var value = values[i];
      var x = i * thickness;
      var y = (1 - value) * size.height;
      canvas.drawRect(Rect.fromLTWH(x, 0, thickness, size.height), backgroundPaint);
      canvas.drawRect(Rect.fromLTWH(x, y, thickness, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant MultiPainter oldDelegate) {
    return oldDelegate.values != this.values;
  }
}

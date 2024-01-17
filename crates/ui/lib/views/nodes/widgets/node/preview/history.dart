import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/plugin/nodes.dart';

class HistoryRenderer extends StatefulWidget {
  final NodesPluginApi pluginApi;
  final String path;

  HistoryRenderer(this.pluginApi, this.path);

  @override
  State<HistoryRenderer> createState() => _HistoryRendererState();
}

class _HistoryRendererState extends State<HistoryRenderer> {
  NodeHistoryPointer? pointer;

  _HistoryRendererState();

  @override
  void initState() {
    super.initState();
    _updatePointer();
  }

  @override
  void didUpdateWidget(HistoryRenderer oldWidget) {
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
        child: pointer == null ? Container() : HistoryPaint(pointer: pointer!));
  }
}

class HistoryPaint extends StatefulWidget {
  final NodeHistoryPointer pointer;

  const HistoryPaint({required this.pointer, Key? key}) : super(key: key);

  @override
  State<HistoryPaint> createState() => _HistoryPaintState();
}

class _HistoryPaintState extends State<HistoryPaint> with SingleTickerProviderStateMixin {
  List<double> history = [];
  late final Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) => setState(() {
          if (widget.pointer.isDisposed) {
            history = [];
            return;
          }
          history = widget.pointer.readHistory();
        }));
    ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: HistoryPainter(history), size: Size(300, 200), willChange: true);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }
}

class HistoryPainter extends CustomPainter {
  final List<double> history;

  HistoryPainter(this.history);

  @override
  void paint(Canvas canvas, Size size) {
    Paint historyPaint = Paint()
      ..color = Color(0xffffffff)
      ..style = PaintingStyle.stroke;
    Paint historyBackgroundPaint = Paint()
      ..color = Color(0x11ffffff)
      ..style = PaintingStyle.fill;
    var path = Path();
    var xSteps = size.width / (history.length - 1);

    path.moveTo(-1, size.height + 1);
    for (var i = 0; i < history.length; i++) {
      var value = history[i];
      var x = i * xSteps;
      var y = (1 - value) * size.height;

      path.lineTo(x, y);
    }
    path.lineTo(size.width + 1, size.height + 1);
    path.close();
    canvas.drawPath(path, historyPaint);
    canvas.drawPath(path, historyBackgroundPaint);
    canvas.clipRect(Rect.fromLTRB(0, 0, size.width, size.height));
  }

  @override
  bool shouldRepaint(covariant HistoryPainter oldDelegate) {
    return oldDelegate.history != this.history;
  }
}

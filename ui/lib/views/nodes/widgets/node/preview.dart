import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';

class NodePreview extends StatelessWidget {
  final Node node;

  NodePreview(this.node);

  @override
  Widget build(BuildContext context) {
    if (node.preview != Node_NodePreviewType.History) {
      return Container();
    }

    var nodesApi = context.read<NodesApi>();
    if (!(nodesApi is NodesPluginApi)) {
      return Container();
    }
    NodesPluginApi nodesPluginApi = nodesApi;
    return HistoryRenderer(nodesPluginApi, node.path);
  }
}

class HistoryRenderer extends StatefulWidget {
  final NodesPluginApi pluginApi;
  final String path;

  HistoryRenderer(this.pluginApi, this.path);

  @override
  State<HistoryRenderer> createState() => _HistoryRendererState(pluginApi.getHistoryPointer(path));
}

class _HistoryRendererState extends State<HistoryRenderer> {
  final Future<NodeHistoryPointer> history;

  _HistoryRendererState(this.history);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        clipBehavior: Clip.antiAlias,
        child: FutureBuilder(
          future: history,
          builder: (context, AsyncSnapshot<NodeHistoryPointer> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return HistoryPaint(pointer: snapshot.data!);
          },
        ));
  }
}

class HistoryPaint extends StatefulWidget {
  final NodeHistoryPointer pointer;

  const HistoryPaint({required this.pointer, Key? key}) : super(key: key);

  @override
  State<HistoryPaint> createState() => _HistoryPaintState(pointer);
}

class _HistoryPaintState extends State<HistoryPaint> with SingleTickerProviderStateMixin {
  final NodeHistoryPointer pointer;
  List<double> history = [];
  late final Ticker ticker;

  _HistoryPaintState(this.pointer);

  @override
  void initState() {
    super.initState();
    ticker = createTicker((elapsed) => setState(() => history = pointer.readHistory()));
    ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: HistoryPainter(history), size: Size(300, 200));
  }

  @override
  void dispose() {
    ticker.dispose();
    pointer.dispose();
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

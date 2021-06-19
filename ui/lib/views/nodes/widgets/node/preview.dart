import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/preview_handler.dart';
import 'package:mizer/protos/nodes.pb.dart';

class NodePreview extends StatelessWidget {
  final Node node;

  NodePreview(this.node);

  @override
  Widget build(BuildContext context) {
    if (node.preview != Node_NodePreviewType.History) {
      return Container();
    }

    var previewHandler = context.read<PreviewHandler>();
    var history$ = Stream.periodic(Duration(milliseconds: 32))
        .asyncMap((event) => previewHandler.getNodeHistory(node.path));
    return StreamBuilder(
        stream: history$,
        builder: (context, snapshot) {
          return HistoryRenderer(snapshot.data);
        });
  }
}

class HistoryRenderer extends StatelessWidget {
  final List<double> history;
  final HistoryRendererPainter painter;

  HistoryRenderer(this.history) : painter = HistoryRendererPainter(history);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2)
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(painter: this.painter, size: Size(300, 200)));
  }
}

class HistoryRendererPainter extends CustomPainter {
  final List<double> history;

  HistoryRendererPainter(this.history);

  @override
  void paint(Canvas canvas, Size size) {
    if (history == null) {
      return;
    }
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
  bool shouldRepaint(covariant HistoryRendererPainter oldDelegate) {
    return this.history != oldDelegate.history;
  }
}

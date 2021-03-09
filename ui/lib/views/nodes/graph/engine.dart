import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/nodes.pb.dart';

import 'overlay.dart';
import 'state.dart';

class GraphEngine extends StatelessWidget {
  final Nodes nodes;
  final Widget child;

  GraphEngine({this.nodes, this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GraphBloc(nodes), child: GraphEngineInternal(this.child, this.nodes));
  }
}

class GraphEngineInternal extends StatefulWidget {
  final Nodes nodes;
  final Widget child;

  GraphEngineInternal(this.child, this.nodes);

  @override
  _GraphEngineInternalState createState() => _GraphEngineInternalState();
}

class _GraphEngineInternalState extends State<GraphEngineInternal> {
  GlobalKey _widgetKey = GlobalKey();
  RenderObject renderObject;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  Widget build(BuildContext context) {
    context.read<GraphBloc>().update(widget.nodes);
    return Stack(children: [
      GraphOverlay(renderObject),
      this.widget.child,
    ], key: _widgetKey);
  }

  void _afterLayout(_) {
    setState(() {
      this.renderObject = _widgetKey.currentContext.findRenderObject();
    });
  }
}

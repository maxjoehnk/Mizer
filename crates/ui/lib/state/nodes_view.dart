import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:provider/provider.dart';

import 'nodes_bloc.dart';

class NodesViewState extends StatefulWidget {
  final Widget child;

  const NodesViewState({required this.child, Key? key}) : super(key: key);

  @override
  _NodesViewStateState createState() => _NodesViewStateState();
}

class _NodesViewStateState extends State<NodesViewState> {
  NodeEditorModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodesBloc, PipelineState>(builder: (context, nodes) {
      _updateModel(nodes);
      return SizeChangedLayoutNotifier(
        child: ChangeNotifierProvider<NodeEditorModel>.value(
            value: model!, builder: (context, _) => widget.child),
      );
    });
  }

  _updateModel(PipelineState state) {
    if (model == null) {
      model = NodeEditorModel(state);
    } else {
      model!.refresh(state);
    }
  }
}

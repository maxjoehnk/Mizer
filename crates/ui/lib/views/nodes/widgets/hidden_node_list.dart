import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/node_control.dart';
import 'package:provider/provider.dart';

class HiddenNodeList extends StatelessWidget {
  final List<NodeModel> nodes;
  final String? search;

  const HiddenNodeList({required this.nodes, Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListView(
          children: nodes
              .search([(n) => n.node.path, (n) => n.node.details.displayName], search).map((node) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Consumer<NodeEditorModel>(
            builder: (context, model, _) => Draggable<NodeModel>(
              data: node,
              child: NodeControl(node, collapsed: true),
              childWhenDragging: Container(),
              feedback: RepositoryProvider<NodesApi>.value(
                value: context.read(),
                child: ChangeNotifierProvider<NodeEditorModel>.value(
                    value: model,
                    builder: (context, child) => Transform.scale(
                          scale: model.transformationController.value.getMaxScaleOnAxis(),
                          child: NodeControl(node),
                        )),
              ),
            ),
          ),
        );
      }).toList()),
    );
  }
}

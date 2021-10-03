import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/nodes/widgets/toolbar.dart';
import 'package:mizer/widgets/popup_menu/popup_menu.dart';
import 'package:mizer/widgets/popup_menu/popup_menu_route.dart';
import 'package:provider/provider.dart';

import 'models/node_editor_model.dart';
import 'widgets/editor_layers/canvas_drop_layer.dart';
import 'widgets/editor_layers/graph_paint_layer.dart';
import 'widgets/editor_layers/nodes_layer.dart';
import 'widgets/hidden_node_list.dart';
import 'widgets/properties/node_properties.dart';

class FetchNodesView extends StatefulWidget {
  @override
  State<FetchNodesView> createState() => _FetchNodesViewState();
}

class _FetchNodesViewState extends State<FetchNodesView> {
  NodeEditorModel model;

  @override
  Widget build(BuildContext context) {
    context.read<NodesBloc>().add(FetchNodes());
    return BlocBuilder<NodesBloc, Nodes>(builder: (context, nodes) {
      _updateModel(nodes);
      return SizeChangedLayoutNotifier(
        child: ChangeNotifierProvider<NodeEditorModel>.value(
            value: model, builder: (context, _) => SizedBox.expand(child: NodesView())),
      );
    });
  }

  _updateModel(Nodes nodes) {
    if (model == null) {
      model = NodeEditorModel(nodes);
    } else {
      model.refresh(nodes);
    }
  }
}

class NodesView extends StatefulWidget {
  @override
  _NodesViewState createState() => _NodesViewState();
}

class _NodesViewState extends State<NodesView> with WidgetsBindingObserver {
  Offset addMenuPosition;
  bool showHiddenNodes = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      afterLayout(context);
    });

    return Consumer<NodeEditorModel>(
      builder: (context, model, _) => Stack(
        children: [
          GestureDetector(
            onSecondaryTapUp: (event) {
              Navigator.of(context).push(PopupMenuRoute(
                  position: event.globalPosition,
                  child: PopupMenu(
                      categories: NODES, onSelect: (nodeType) => _addNode(model, nodeType))));
              setState(() {
                addMenuPosition = event.localPosition;
              });
            },
            child: Stack(children: [
              SizedBox.expand(
                  child: InteractiveViewer(
                      transformationController: model.transformationController,
                      boundaryMargin: EdgeInsets.all(double.infinity),
                      minScale: 0.1,
                      maxScale: 10.0,
                      child: SizedBox.expand())),
              // Transform(
              //   transform: model.transformationController.value,
              //   child: IgnorePointer(child: CanvasBackgroundLayer(child: SizedBox.expand())),
              // ),
              Transform(
                  transform: model.transformationController.value,
                  child: IgnorePointer(child: GraphPaintLayer(model: model))),
              CanvasDropLayer(),
              NodesTarget(),
            ]),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: NodesToolbar(
              onToggleHidden: () => setState(() => showHiddenNodes = !showHiddenNodes),
              showHiddenNodes: showHiddenNodes,
            )
          ),
          if (!showHiddenNodes) Positioned(
              top: 16 + TOOLBAR_HEIGHT,
              right: 16,
              bottom: 16,
              width: 256,
              child: NodePropertiesPane(node: model.selectedNode?.node)),
          if (showHiddenNodes) Positioned(
              top: TOOLBAR_HEIGHT,
              right: 0,
              bottom: 0,
              width: 256,
              child: HiddenNodeList(nodes: model.hidden)),
        ],
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WidgetsBinding.instance.addObserver(this);
      afterLayout(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void afterLayout(BuildContext context) {
    NodeEditorModel model = Provider.of<NodeEditorModel>(context, listen: false);
    model.updateNodes();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }

  void _addNode(NodeEditorModel model, Node_NodeType nodeType) {
    var transformedPosition = model.transformationController.toScene(addMenuPosition);
    var position = transformedPosition / MULTIPLIER;
    context.read<NodesBloc>().add(AddNode(nodeType: nodeType, position: position));
    setState(() {
      addMenuPosition = null;
    });
  }
}

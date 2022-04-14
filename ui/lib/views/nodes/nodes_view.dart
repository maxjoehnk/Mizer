import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/popup/popup_menu.dart';
import 'package:mizer/widgets/popup/popup_route.dart';
import 'package:provider/provider.dart';

import 'models/node_editor_model.dart';
import 'widgets/editor_layers/canvas_drop_layer.dart';
import 'widgets/editor_layers/graph_paint_layer.dart';
import 'widgets/editor_layers/nodes_layer.dart';
import 'widgets/hidden_node_list.dart';
import 'widgets/properties/node_properties.dart';

class FetchNodesView extends StatelessWidget {
  const FetchNodesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NodesBloc>().add(FetchNodes());
    return SizedBox.expand(child: Consumer<NodeEditorModel>(builder: (context, model, _) {
      return NodesView(nodeEditorModel: model);
    }));
  }
}

class NodesView extends StatefulWidget {
  final NodeEditorModel nodeEditorModel;

  const NodesView({Key? key, required this.nodeEditorModel}) : super(key: key);

  @override
  _NodesViewState createState() => _NodesViewState();
}

class _NodesViewState extends State<NodesView> with WidgetsBindingObserver {
  Offset? addMenuPosition;
  bool showHiddenNodes = false;

  NodeEditorModel get model {
    return widget.nodeEditorModel;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      afterLayout(context);
    });

    return HotkeyProvider(
      hotkeySelector: (hotkeys) => hotkeys.nodes,
      hotkeyMap: {
        // TODO: determine position for new node
        "add_node": () => {},
      },
      // TODO: nodes render above the panel header
      child: Panel(
        label: "Nodes",
        trailingHeader: [
          MizerIconButton(
              onClick: () => setState(() => showHiddenNodes = !showHiddenNodes),
              icon: showHiddenNodes ? MdiIcons.eyeOffOutline : MdiIcons.eyeOutline,
              label: "Show hidden nodes")
        ],
        child: Stack(
          children: [
            GestureDetector(
                onSecondaryTapUp: (event) {
                  Navigator.of(context).push(MizerPopupRoute(
                      position: event.globalPosition,
                      child: PopupMenu<Node_NodeType>(
                          categories: NODES, onSelect: (nodeType) => _addNode(model, nodeType))));
                  setState(() {
                    addMenuPosition = event.localPosition;
                  });
                },
                child: Overlay(initialEntries: [
                  OverlayEntry(
                    builder: (context) => Stack(children: [
                      SizedBox.expand(
                          child: InteractiveViewer(
                              transformationController: model.transformationController,
                              boundaryMargin: EdgeInsets.all(double.infinity),
                              minScale: 0.1,
                              maxScale: 10.0,
                              child: SizedBox.expand())),
                      Transform(
                          transform: model.transformationController.value,
                          child: IgnorePointer(child: GraphPaintLayer(model: model))),
                      CanvasDropLayer(),
                      NodesTarget(),
                    ]),
                  )
                ])),
            if (!showHiddenNodes)
              Positioned(
                  top: 16,
                  right: 16,
                  bottom: 16,
                  width: 256,
                  child: NodePropertiesPane(node: model.selectedNode?.node)),
            if (showHiddenNodes)
              Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  width: 256,
                  child: HiddenNodeList(nodes: model.hidden)),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      WidgetsBinding.instance!.addObserver(this);
      afterLayout(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void afterLayout(BuildContext context) {
    model.updateNodes();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    model.update();
  }

  void _addNode(NodeEditorModel model, Node_NodeType nodeType) {
    var transformedPosition = model.transformationController.toScene(addMenuPosition!);
    var position = transformedPosition / MULTIPLIER;
    context.read<NodesBloc>().add(AddNode(nodeType: nodeType, position: position));
    setState(() {
      addMenuPosition = null;
    });
  }
}

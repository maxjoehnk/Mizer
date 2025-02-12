import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart' hide Tab;
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/available_nodes.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/views/nodes/node_documenter.dart';
import 'package:mizer/views/nodes/widgets/editor_layers/comments_layer.dart';
import 'package:mizer/views/nodes/widgets/minimap/minimap.dart';
import 'package:mizer/views/nodes/widgets/node/base_node.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/interactive_surface/interactive_surface.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/popup/popup_menu.dart';
import 'package:mizer/widgets/popup/popup_route.dart';
import 'package:provider/provider.dart';

import 'models/node_editor_model.dart';
import 'models/node_model.dart';
import 'widgets/editor_layers/add_comment_layer.dart';
import 'widgets/editor_layers/canvas_drop_layer.dart';
import 'widgets/editor_layers/drag_selection_layer.dart';
import 'widgets/editor_layers/graph_paint_layer.dart';
import 'widgets/editor_layers/nodes_layer.dart';
import 'widgets/hidden_node_list.dart';
import 'widgets/node/preview.dart';
import 'widgets/properties/properties_pane.dart';

const double SidebarWidth = 550;
const double PathBreadcrumbHeight = 32;
const bool EnableScreenshot = !kReleaseMode;

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
  SelectionState? _selectionState;
  String? nodeSearch;
  bool _isAddingComment = false;

  NodeEditorModel get model {
    return widget.nodeEditorModel;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      afterLayout(context);
    });

    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.nodes,
      hotkeyMap: {
        // TODO: determine position for new node
        "add_node": () => {},
        "add_comment": () => _toggleCommentEditor(context),
        "duplicate_node": () => _duplicateNodes(context),
        "delete_node": () => _deleteNodes(context),
        "group_nodes": () => _groupNodes(context),
        "rename_node": () => _renameNode(context),
        "align_nodes": () => _alignNodes(context),
      },
      child: Row(
        children: [
          Expanded(
            child: Panel(
              label: "Nodes",
              child: Stack(
                children: [
                  GestureDetector(
                      onSecondaryTapUp: (event) {
                        _openAddNodeMenu(context,
                            globalPosition: event.globalPosition,
                            localPosition: event.localPosition);
                      },
                      child: Overlay(initialEntries: [
                        OverlayEntry(
                          builder: (context) => Stack(children: [
                            CanvasBackgroundLayer(model.transformationController.value),
                            TransformLayer(transformationController: model.transformationController),
                            CommentsTarget(),
                            Transform(
                                transform: model.transformationController.value,
                                child: IgnorePointer(child: GraphPaintLayer(model: model))),
                            if (!_isAddingComment) GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onDoubleTapDown: (event) {
                                _openAddNodeMenu(context,
                                    globalPosition: event.globalPosition,
                                    localPosition: event.localPosition);
                              },
                              child: NodesDragSelectionLayer(
                                  nodes: model.nodes,
                                  transformation: model.transformationController.value,
                                  selectionState: _selectionState,
                                  onUpdateSelection: (selection) =>
                                      setState(() => _selectionState = selection)),
                            ),
                            if (_isAddingComment) AddCommentLayer(
                              onAddComment: (rect) => _addComment(context, rect),
                              transformation: model.transformationController.value,
                              selectionState: _selectionState,
                                  onUpdateSelection: (selection) =>
                                      setState(() => _selectionState = selection)),
                            CanvasDropLayer(),
                            NodesTarget(),
                            if (_selectionState != null) SelectionIndicator(_selectionState!),
                            Positioned(bottom: 8 + PathBreadcrumbHeight, right: 8, child: Minimap(transformationController: model.transformationController)),
                          ]),
                        )
                      ])),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      height: PathBreadcrumbHeight,
                      child: Container(
                          color: Colors.grey.shade800,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            MizerButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("/"),
                                ),
                                onClick: () => model.closeContainer()),
                            ...model.path.map((p) => Center(child: Text(p)))
                          ])))
                ],
              ),
              actions: [
                PanelActionModel(
                    label: "Group Nodes".i18n,
                    onClick: () => _groupNodes(context),
                    hotkeyId: "group_nodes"),
                PanelActionModel(
                    label: "Delete Nodes".i18n,
                    disabled: model.selection.isEmpty || model.selection.where((s) => s.node.canDelete).isEmpty,
                    onClick: () => _deleteNodes(context),
                    hotkeyId: "delete_node"),
                PanelActionModel(
                    label: "Duplicate Nodes".i18n,
                    disabled: model.selection.isEmpty || model.selection.where((s) => s.node.canDuplicate).isEmpty,
                    onClick: () => _duplicateNodes(context),
                    hotkeyId: "duplicate_node"),
                PanelActionModel(
                    label: "Rename Node".i18n,
                    disabled: model.selectedNode == null || !model.selectedNode!.node.canRename,
                    onClick: () => _renameNode(context),
                    hotkeyId: "rename_node"),
                PanelActionModel(
                    label: "Align Selection".i18n,
                    disabled: model.selection.isEmpty,
                    onClick: () => _alignNodes(context),
                    hotkeyId: "align_nodes"),
                PanelActionModel(
                    label: "Add Comment".i18n,
                    activated: _isAddingComment,
                    onClick: () => _toggleCommentEditor(context),
                    hotkeyId: "add_comment"),
                if (EnableScreenshot)
                  PanelActionModel(
                      label: "Document Node",
                      disabled: model.selectedNode == null,
                      onClick: () => _documentNode(context)),
              ],
            ),
          ),
          Container(
            width: SidebarWidth,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Panel(
                          padding: false,
                          label: "Properties".i18n,
                          child: NodePropertiesPane(node: model.selectedNode?.node, comment: model.selectedComment, onUpdate: _refresh)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: Panel(
                                padding: false,
                                label: "Hidden".i18n,
                                onSearch: (search) => setState(() => nodeSearch = search),
                                child: HiddenNodeList(nodes: model.hidden, search: nodeSearch)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: Panel(
                    label: "Preview".i18n,
                    child: model.selectedNode == null
                        ? Container()
                        : NodePreview(model.selectedNode!.node),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _openAddNodeMenu(BuildContext context,
      {required Offset globalPosition, required Offset localPosition}) {
    var availableNodes = context
        .read<NodesBloc>()
        .state
        .availableNodes
        .where((element) => element.category != NodeCategory.NODE_CATEGORY_NONE);
    var categories = groupBy(availableNodes, (AvailableNode node) => node.category);
    Navigator.of(context).push(MizerPopupRoute(
        position: globalPosition,
        child: PopupMenu<CreateNode>(
            categories: categories.entries
                .sorted((lhs, rhs) => lhs.key.name.compareTo(rhs.key.name))
                .map((e) => PopupCategory(
                    label: CATEGORY_NAMES[e.key]!,
                    items: e.value
                        .map((n) {
                          if (n.templates.isEmpty) {
                            return PopupItem(CreateNode(n.type), n.name, description: n.description);
                          }
                          return PopupCategory(
                              label: n.name,
                              description: n.description,
                              items: [
                                PopupItem(CreateNode(n.type), "Default", description: n.description, searchLabel: n.name, sortOrder: SortOrder.First),
                                ...n.templates
                                  .map((t) => PopupItem(CreateNode(n.type, template: t.name), t.name, description: t.description))
                                ]
                          );
                        })
                        .toList()))
                .toList(),
            onSelect: (nodeType) => _addNode(model, nodeType))));
    setState(() {
      addMenuPosition = localPosition;
    });
  }

  void _deleteNodes(BuildContext context) {
    if (model.selection.where((s) => s.node.canDelete).isNotEmpty) {
      context.read<NodesBloc>().add(DeleteNodes(widget.nodeEditorModel.selection
          .where((s) => s.node.canDelete)
          .map((e) => e.node.path)
          .toList()));
    }
  }

  void _duplicateNodes(BuildContext context) {
    if (model.selection.where((s) => s.node.canDuplicate).isNotEmpty) {
      context.read<NodesBloc>().add(DuplicateNodes(
          widget.nodeEditorModel.selection
              .where((s) => s.node.canDuplicate)
              .map((e) => e.node.path)
              .toList(),
          parent: widget.nodeEditorModel.parent?.node.path));
    }
  }

  void _renameNode(BuildContext context) async {
    if (widget.nodeEditorModel.selectedNode != null &&
        widget.nodeEditorModel.selectedNode!.node.canRename) {
      String? result = await showDialog(
          context: context,
          builder: (BuildContext context) =>
              RenameNodeDialog(path: widget.nodeEditorModel.selectedNode!.node.path));
      if (result != null) {
        context
            .read<NodesBloc>()
            .add(RenameNode(widget.nodeEditorModel.selectedNode!.node.path, result));
      }
    }
  }

  void _alignNodes(BuildContext context) {
    var nodes = widget.nodeEditorModel.selection.map((n) => MoveNode(n.node.path, n.align())).toList();
    context.read<NodesBloc>().add(MoveNodes(nodes));
  }

  void _groupNodes(BuildContext context) {
    List<NodeModel> nodes = [];
    if (widget.nodeEditorModel.selectedNode != null) {
      nodes.add(widget.nodeEditorModel.selectedNode!);
    }
    nodes.addAll(widget.nodeEditorModel.otherSelectedNodes);
    if (nodes.isEmpty) {
      return;
    }
    context.read<NodesBloc>().add(GroupNodes(nodes.map((n) => n.node.path).toList(),
        parent: widget.nodeEditorModel.parent?.node.path));
  }

  void _documentNode(BuildContext context) async {
    BaseNodeState nodeState = model.selectedNode!.key.currentState!;
    await documentNode(context, nodeState);
  }

  void _toggleCommentEditor(BuildContext context) {
    setState(() {
      _isAddingComment = !_isAddingComment;
    });
  }

  void _addComment(BuildContext context, Rect rect) {
    var position = rect.topLeft / MULTIPLIER;
    var size = rect.size / MULTIPLIER;

    context.read<NodesBloc>().add(AddComment(position, size, parent: model.parent?.node.path));

    setState(() {
      _isAddingComment = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WidgetsBinding.instance.addObserver(this);
      afterLayout(context);
    });
    context.read<NodesApi>().openNodesView();
    super.initState();
  }

  @override
  void activate() {
    context.read<NodesApi>().openNodesView();
    super.activate();
  }

  @override
  void deactivate() {
    context.read<NodesApi>().closeNodesView();
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  void _addNode(NodeEditorModel model, CreateNode req) {
    var transformedPosition = model.transformationController.toScene(addMenuPosition!);
    var position = transformedPosition / MULTIPLIER;

    print("add");
    print(addMenuPosition);
    print(transformedPosition);
    print(position);

    context
        .read<NodesBloc>()
        .add(AddNode(nodeType: req.nodeType, template: req.template, position: position, parent: model.parent?.node.path));
    setState(() {
      addMenuPosition = null;
    });
  }

  void _refresh() {
    context.read<NodesBloc>().add(FetchNodes());
  }
}

class CreateNode {
  final String nodeType;
  final String? template;

  CreateNode(this.nodeType, { this.template });
}

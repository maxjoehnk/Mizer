import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/views/nodes/widgets/node_preview.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/nodes/consts.dart';
import 'package:mizer/views/nodes/models/node_model.dart';
import 'package:mizer/views/nodes/widgets/node/container.dart';
import 'package:mizer/views/nodes/widgets/node/footer.dart';
import 'package:mizer/views/nodes/widgets/node/header.dart';
import 'ports.dart';
import 'preview.dart';
import 'package:mizer/views/nodes/widgets/node/tabs.dart';

class BaseNode extends StatefulWidget {
  final NodeModel nodeModel;
  final Widget child;
  final bool selected;
  final bool selectedAdditionally;
  final bool collapsed;
  final bool connected;
  final Function() onSelect;
  final Function() onSelectAdditional;
  late final List<CustomNodeTab> tabs;

  BaseNode(this.nodeModel,
      {required this.child,
      this.selected = false,
      required this.onSelect,
      required this.onSelectAdditional,
      this.collapsed = false,
      this.connected = false,
      List<CustomNodeTab>? tabs,
      Key? key,
      required this.selectedAdditionally})
      : super(key: key) {
    this.tabs = tabs ?? [];
  }

  factory BaseNode.fromNode(NodeModel node,
      {required Function() onSelect,
      required Function() onSelectAdditional,
      bool connected = false,
      bool selected = false,
      bool collapsed = false,
      Key? key,
      required bool selectedAdditionally}) {
    List<CustomNodeTab> tabs = [];
    if (node.node.type == "container") {
      tabs.add(CustomNodeTab(
          tab: NodeTab.ContainerEditor, icon: MdiIcons.pencil, builder: (model) => Container()));
    }

    return BaseNode(
      node,
      child: Container(),
      onSelect: onSelect,
      onSelectAdditional: onSelectAdditional,
      selected: selected,
      selectedAdditionally: selectedAdditionally,
      connected: connected,
      collapsed: collapsed,
      key: key,
      tabs: tabs,
    );
  }

  @override
  State<BaseNode> createState() => BaseNodeState();
}

class BaseNodeState extends State<BaseNode> {
  final GlobalKey _repaintKey = GlobalKey();
  bool _screenshotMode = false;

  Node get node {
    return widget.nodeModel.node;
  }

  NodeTab get selectedTab {
    return widget.nodeModel.tab;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _repaintKey,
      child: ContextMenu(
        menu: Menu(items: [
          MenuItem(label: "Hide", action: () => _onHideNode(context)),
          MenuItem(label: "Disconnect Ports", action: () => _onDisconnectPorts(context)),
          if (widget.nodeModel.node.canRename)
            MenuItem(label: "Rename", action: () => _onRenameNode(context)),
          if (widget.nodeModel.node.canDuplicate)
            MenuItem(label: "Duplicate", action: () => _onDuplicateNode(context)),
          if (widget.nodeModel.node.canDelete)
            MenuItem(label: "Delete", action: () => _onDeleteNode(context)),
        ]),
        child: Container(
          margin: _screenshotMode ? EdgeInsets.all(8.0) : EdgeInsets.zero,
          width: NODE_BASE_WIDTH,
          child: GestureDetector(
            onTap: () {
              if (HardwareKeyboard.instance.isShiftPressed) {
                this.widget.onSelectAdditional();
              } else {
                this.widget.onSelect();
              }
            },
            child: NodeContainer(
              designer: node.designer,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NodeHeader(
                          this.node.path, this.node.details.displayName, this.node.details.category,
                          collapsed: widget.collapsed),
                      if (!widget.collapsed)
                        Stack(children: [
                          _portsView(),
                          if (selectedTab == NodeTab.Preview) _previewView(),
                          if (selectedTab == NodeTab.ContainerEditor) _containerEditor(context),
                        ]),
                      if (!widget.collapsed)
                        NodeFooter(
                          node: node,
                          tabs: widget.tabs,
                          selectedTab: selectedTab,
                          onSelectTab: (tab) => widget.nodeModel.selectTab(tab),
                        )
                    ]),
              ),
              selected: !_screenshotMode && widget.selected,
              selectedAdditionally: widget.selectedAdditionally,
              connected: widget.connected,
            ),
          ),
        ),
      ),
    );
  }

  Widget _portsView() {
    bool collapsed = selectedTab != NodeTab.Ports;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NodePortList(this.node, inputs: false, collapsed: collapsed),
            NodePortList(this.node, inputs: true, collapsed: collapsed),
          ]),
    );
  }

  Widget _previewView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RepaintBoundary(child: NodePreview(this.node)),
    );
  }

  Widget _containerEditor(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () {
            context.read<NodeEditorModel>().openContainer(widget.nodeModel);
          },
          child: ContainerPreview(node: widget.nodeModel)),
    );
  }

  void _onHideNode(BuildContext context) async {
    context.read<NodesBloc>().add(HideNode(node.path));
  }

  void _onDisconnectPorts(BuildContext context) async {
    context.read<NodesBloc>().add(DisconnectPorts(node.path));
  }

  void _onRenameNode(BuildContext context) async {
    String? result = await showDialog(
        context: context, builder: (BuildContext context) => RenameNodeDialog(path: node.path));
    if (result != null) {
      context.read<NodesBloc>().add(RenameNode(node.path, result));
    }
  }

  void _onDuplicateNode(BuildContext context) async {
    var parent = context.read<NodeEditorModel>().parent?.node.path;
    context.read<NodesBloc>().add(DuplicateNodes([node.path], parent: parent));
  }

  void _onDeleteNode(BuildContext context) async {
    context.read<NodesBloc>().add(DeleteNodes([node.path]));
  }

  Future<ui.Image> screenshot() async {
    await _setScreenshotMode(true);
    final RenderRepaintBoundary boundary =
        _repaintKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    await _setScreenshotMode(false);

    return image;
  }

  Future<void> _setScreenshotMode(bool screenshotMode) {
    setState(() {
      _screenshotMode = screenshotMode;
    });
    var completer = Completer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete();
    });

    return completer.future;
  }
}

const NON_DUPLICATABLE_NODE_TYPES = [
  "programmer",
  "transport",
  "fixture",
  "group",
  "container"
];

const NON_RENAMEABLE_NODE_TYPES = ["programmer", "transport"];

const UNDELETABLE_NODE_TYPES = ["programmer", "transport", "fixture", "group"];

extension NodeOptionExtensions on Node {
  bool get canRename {
    return !NON_RENAMEABLE_NODE_TYPES.contains(type);
  }

  bool get canDuplicate {
    return !NON_DUPLICATABLE_NODE_TYPES.contains(type);
  }

  bool get canDelete {
    return !UNDELETABLE_NODE_TYPES.contains(type);
  }
}

class RenameNodeDialog extends StatefulWidget {
  final String path;

  const RenameNodeDialog({required this.path, Key? key}) : super(key: key);

  @override
  State<RenameNodeDialog> createState() => _RenameNodeDialogState();
}

class _RenameNodeDialogState extends State<RenameNodeDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Node",
      content: Column(children: [
        TextField(
          controller: _nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Path".i18n),
          onSubmitted: (value) => Navigator.of(context).pop(value),
        )
      ]),
      actions: [
        PopupAction(
          "Cancel",
          () => Navigator.of(context).pop(),
        ),
        PopupAction(
          "Rename",
          () => Navigator.of(context).pop(_nameController.text),
        ),
      ],
    );
  }
}

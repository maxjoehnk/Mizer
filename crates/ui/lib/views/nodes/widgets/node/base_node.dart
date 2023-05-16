import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/nodes/models/node_editor_model.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import '../../models/node_model.dart';
import 'container.dart';
import 'footer.dart';
import 'header.dart';
import 'ports.dart';
import 'preview.dart';
import 'tabs.dart';

class BaseNode extends StatelessWidget {
  final NodeModel nodeModel;
  final Widget child;
  final bool selected;
  final bool selectedAdditionally;
  final bool collapsed;
  final bool connected;
  final Function() onSelect;
  final Function() onSelectAdditional;
  late List<CustomNodeTab> tabs;

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
    if (node.node.type == Node_NodeType.CONTAINER) {
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

  Node get node {
    return nodeModel.node;
  }

  NodeTab get selectedTab {
    return nodeModel.tab;
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Hide", action: () => _onHideNode(context)),
        MenuItem(label: "Disconnect Ports", action: () => _onDisconnectPorts(context)),
        if (nodeModel.node.canRename)
          MenuItem(label: "Rename", action: () => _onRenameNode(context)),
        if (nodeModel.node.canDuplicate)
          MenuItem(label: "Duplicate", action: () => _onDuplicateNode(context)),
        if (nodeModel.node.canDelete)
          MenuItem(label: "Delete", action: () => _onDeleteNode(context)),
      ]),
      child: Container(
        width: NODE_BASE_WIDTH,
        child: GestureDetector(
          onTap: () {
            if (RawKeyboard.instance.keysPressed.any((key) => [
                  LogicalKeyboardKey.shift,
                  LogicalKeyboardKey.shiftLeft,
                  LogicalKeyboardKey.shiftRight,
                ].contains(key))) {
              this.onSelectAdditional();
            } else {
              this.onSelect();
            }
          },
          child: NodeContainer(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText2!,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NodeHeader(this.node.path, this.node.type, collapsed: collapsed),
                    if (!collapsed)
                      Stack(children: [
                        _portsView(),
                        if (selectedTab == NodeTab.Preview) _previewView(),
                        if (selectedTab == NodeTab.ContainerEditor) _containerEditor(context),
                      ]),
                    if (!collapsed)
                      NodeFooter(
                        node: node,
                        tabs: tabs,
                        selectedTab: selectedTab,
                        onSelectTab: (tab) => nodeModel.selectTab(tab),
                      )
                  ]),
            ),
            selected: selected,
            selectedAdditionally: selectedAdditionally,
            connected: connected,
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
    // TODO: show preview of child nodes
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: ElevatedButton(
          onPressed: () {
            context.read<NodeEditorModel>().openContainer(nodeModel);
          },
          child: Text("Open")),
    ));
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
    context.read<NodesBloc>().add(DuplicateNode(node.path, parent: parent));
  }

  void _onDeleteNode(BuildContext context) async {
    context.read<NodesBloc>().add(DeleteNode(node.path));
  }
}

const NON_DUPLICATABLE_NODE_TYPES = [
  Node_NodeType.PROGRAMMER,
  Node_NodeType.TRANSPORT,
  Node_NodeType.FIXTURE,
  Node_NodeType.SEQUENCER,
  Node_NodeType.GROUP,
  Node_NodeType.CONTAINER,
];

const NON_RENAMEABLE_NODE_TYPES = [
  Node_NodeType.PROGRAMMER,
  Node_NodeType.TRANSPORT,
];

const UNDELETABLE_NODE_TYPES = [
  Node_NodeType.PROGRAMMER,
  Node_NodeType.TRANSPORT,
  Node_NodeType.FIXTURE,
  Node_NodeType.SEQUENCER,
  Node_NodeType.GROUP,
];

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

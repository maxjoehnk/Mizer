import 'package:flutter/material.dart' hide MenuItem;
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import '../../models/node_model.dart';
import 'container.dart';
import 'footer.dart';
import 'header.dart';
import 'ports.dart';
import 'preview.dart';

class BaseNode extends StatelessWidget {
  final NodeModel nodeModel;
  final Widget child;
  final bool selected;
  final Function()? onSelect;

  BaseNode(this.nodeModel, {required this.child, this.selected = false, this.onSelect, Key? key})
      : super(key: key);

  factory BaseNode.fromNode(NodeModel node, {Function()? onSelect, bool selected = false, Key? key}) {
    return BaseNode(
      node,
      child: Container(),
      onSelect: onSelect,
      selected: selected,
      key: key,
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
        MenuItem(label: "Duplicate", action: () => _onDuplicateNode(context)),
        MenuItem(label: "Delete", action: () => _onDeleteNode(context)),
      ]),
      child: Container(
        width: NODE_BASE_WIDTH,
        child: GestureDetector(
          onTap: this.onSelect,
          child: NodeContainer(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText2!,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NodeHeader(this.node.path, this.node.type),
                    Stack(children: [
                      _portsView(),
                      if (selectedTab == NodeTab.Preview) _previewView(),
                    ]),
                    NodeFooter(
                      node: node,
                      selectedTab: selectedTab,
                      onSelectTab: (tab) => nodeModel.selectTab(tab),
                    )
                  ]),
            ),
            selected: selected,
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
      child: NodePreview(this.node),
    );
  }

  void _onHideNode(BuildContext context) async {
    context.read<NodesBloc>().add(HideNode(node.path));
  }

  void _onDisconnectPorts(BuildContext context) async {
    context.read<NodesBloc>().add(DisconnectPorts(node.path));
  }

  void _onDuplicateNode(BuildContext context) async {
    context.read<NodesBloc>().add(DuplicateNode(node.path));
  }

  void _onDeleteNode(BuildContext context) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Node"),
          content: SingleChildScrollView(
            child: Text("Delete Node '${node.path}'?"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              autofocus: true,
              child: Text("Delete"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ));
    if (result) {
      context.read<NodesBloc>().add(DeleteNode(node.path));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import 'container.dart';
import 'header.dart';
import 'ports.dart';
import 'preview.dart';

class BaseNode extends StatelessWidget {
  final Node node;
  final Widget child;
  final bool selected;
  final Function()? onSelect;

  BaseNode(this.node, {required this.child, this.selected = false, this.onSelect, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Delete", action: () => _onDeleteNode(context))
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
                    NodeHeader(this.node.path),
                    NodePortList(this.node, inputs: false),
                    NodePortList(this.node, inputs: true),
                    this.child,
                    NodePreview(this.node),
                  ]),
            ),
            selected: selected,
          ),
        ),
      ),
    );
  }

  factory BaseNode.fromNode(Node node, {Function()? onSelect, bool selected = false, Key? key}) {
    return BaseNode(
      node,
      child: Container(),
      onSelect: onSelect,
      selected: selected,
      key: key,
    );
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

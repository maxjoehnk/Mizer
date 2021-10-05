// @dart=2.11
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/widgets/popup_menu/popup_menu.dart';

class AddControlPopup extends StatelessWidget {
  final Nodes nodes;
  final Function(Node_NodeType) onCreateControl;
  final Function(Node) onAddControlForExisting;

  const AddControlPopup({this.nodes, Key key, this.onCreateControl, this.onAddControlForExisting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var compatibleNodes = nodes.nodes.where((node) => isControlNode(node));

    return PopupMenu(
        categories: [
          PopupCategory(label: "Controls", items: [
            PopupItem(Node_NodeType.Button, "Button"),
            PopupItem(Node_NodeType.Fader, "Fader"),
          ]),
          if (compatibleNodes.isNotEmpty)
            PopupCategory(
                label: "Nodes",
                items: compatibleNodes.map((node) => PopupItem(node, node.path)).toList())
        ],
        onSelect: (value) {
          if (value is Node_NodeType) {
            this.onCreateControl(value);
          } else {
            this.onAddControlForExisting(value);
          }
        });
  }
}

List<Node_NodeType> CONTROL_NODES = [
  Node_NodeType.Fader,
  Node_NodeType.Button,
];

bool isControlNode(Node node) {
  return CONTROL_NODES.contains(node.type);
}

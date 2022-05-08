import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/widgets/popup/popup_menu.dart';

class SequenceNode {
  final Sequence sequence;
  final Node node;

  SequenceNode(this.sequence, this.node);
}

class AddControlPopup extends StatelessWidget {
  final List<Node> nodes;
  final List<Sequence> sequences;
  final Function(Node_NodeType) onCreateControl;
  final Function(Node) onAddControlForExisting;

  const AddControlPopup({required this.nodes,  required this.sequences, Key? key, required this.onCreateControl, required this.onAddControlForExisting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controlNodes = nodes.where((node) => isControlNode(node));
    var sequenceNodes = nodes.where((node) => node.type == Node_NodeType.Sequencer).map((node) {
      var sequence = sequences.firstWhere((element) => element.id == node.config.sequencerConfig.sequenceId);

      return SequenceNode(sequence, node);
    }).toList();

    return PopupMenu<dynamic>(
        categories: [
          PopupCategory(label: "New".i18n, items: [
            PopupItem(Node_NodeType.Button, "Button".i18n),
            PopupItem(Node_NodeType.Fader, "Fader".i18n),
          ]),
          if (controlNodes.isNotEmpty)
            PopupCategory(
                label: "Control Nodes".i18n,
                items: controlNodes.map((node) => PopupItem(node, node.path)).toList()),
          if (sequenceNodes.isNotEmpty)
            PopupCategory(label: "Sequences".i18n, items: sequenceNodes.map((e) => PopupItem(e.node, e.sequence.name)).toList())
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

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/widgets/popup/popup_menu.dart';

class SequenceNode {
  final Sequence sequence;
  final Node node;

  SequenceNode(this.sequence, this.node);
}

class GroupNode {
  final Group group;
  final Node node;

  GroupNode(this.group, this.node);
}

class PresetNode {
  final Preset preset;
  final Node node;

  PresetNode(this.preset, this.node);
}

class AddControlPopup extends StatelessWidget {
  final List<Node> nodes;
  final List<Sequence> sequences;
  final List<Group> groups;
  final Presets presets;
  final Function(Node_NodeType) onCreateControl;
  final Function(Node) onAddControlForExisting;

  const AddControlPopup(
      {required this.nodes,
      required this.sequences,
      required this.groups,
      required this.presets,
      Key? key,
      required this.onCreateControl,
      required this.onAddControlForExisting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controlNodes = nodes.where((node) => isControlNode(node));
    var sequenceNodes = nodes
        .where((node) => node.type == Node_NodeType.SEQUENCER)
        .where((node) =>
            sequences.any((element) => element.id == node.config.sequencerConfig.sequenceId))
        .map((node) {
      var sequence =
          sequences.firstWhere((element) => element.id == node.config.sequencerConfig.sequenceId);

      return SequenceNode(sequence, node);
    }).toList();
    var groupNodes = nodes
        .where((node) => node.type == Node_NodeType.GROUP)
        .where((node) => groups.any((element) => element.id == node.config.groupConfig.groupId))
        .map((node) {
      var group = groups.firstWhere((element) => element.id == node.config.groupConfig.groupId);

      return GroupNode(group, node);
    }).toList();
    var colorNodes = _getPresets(presets.colors);
    var intensityNodes = _getPresets(presets.intensities);
    var positionNodes = _getPresets(presets.positions);
    var shutterNodes = _getPresets(presets.shutters);

    return PopupMenu<dynamic>(
        categories: [
          PopupCategory(label: "New".i18n, items: [
            PopupItem(Node_NodeType.BUTTON, "Button".i18n),
            PopupItem(Node_NodeType.FADER, "Fader".i18n),
            PopupItem(Node_NodeType.LABEL, "Label".i18n),
          ]),
          if (controlNodes.isNotEmpty)
            PopupCategory(
                label: "Control Nodes".i18n,
                items: controlNodes.map((node) => PopupItem(node, node.path)).toList()),
          if (sequenceNodes.isNotEmpty)
            PopupCategory(
                label: "Sequences".i18n,
                items: sequenceNodes.map((e) => PopupItem(e.node, e.sequence.name)).toList()),
          if (groupNodes.isNotEmpty)
            PopupCategory(
                label: "Groups".i18n,
                items: groupNodes.map((e) => PopupItem(e.node, e.group.name)).toList()),
          if (colorNodes.isNotEmpty)
            PopupCategory(
                label: "Colors".i18n,
                items: colorNodes.map((e) => PopupItem(e.node, e.preset.label)).toList()),
          if (intensityNodes.isNotEmpty)
            PopupCategory(
                label: "Intensities".i18n,
                items: intensityNodes.map((e) => PopupItem(e.node, e.preset.label)).toList()),
          if (shutterNodes.isNotEmpty)
            PopupCategory(
                label: "Shutters".i18n,
                items: shutterNodes.map((e) => PopupItem(e.node, e.preset.label)).toList()),
          if (positionNodes.isNotEmpty)
            PopupCategory(
                label: "Positions".i18n,
                items: colorNodes.map((e) => PopupItem(e.node, e.preset.label)).toList()),
        ],
        onSelect: (value) {
          if (value is Node_NodeType) {
            this.onCreateControl(value);
          } else {
            this.onAddControlForExisting(value);
          }
        });
  }

  List<PresetNode> _getPresets(List<Preset> presets) {
    return nodes
        .where((node) => node.type == Node_NodeType.PRESET)
        .where((node) => presets.any((p) => p.id == node.config.presetConfig.presetId))
        .map((node) {
      var preset = presets.firstWhere((p) => p.id == node.config.presetConfig.presetId);

      return PresetNode(preset, node);
    }).toList();
  }
}

List<Node_NodeType> CONTROL_NODES = [
  Node_NodeType.FADER,
  Node_NodeType.BUTTON,
  Node_NodeType.LABEL,
];

bool isControlNode(Node node) {
  return CONTROL_NODES.contains(node.type);
}

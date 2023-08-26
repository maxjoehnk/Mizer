import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/layouts.pb.dart';
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
  final Function(ControlType) onCreateControl;
  final Function(PresetId) onCreatePresetControl;
  final Function(int) onCreateGroupControl;
  final Function(int) onCreateSequenceControl;
  final Function(Node) onAddControlForExisting;

  const AddControlPopup(
      {required this.nodes,
      required this.sequences,
      required this.groups,
      required this.presets,
      Key? key,
      required this.onCreateControl,
      required this.onCreatePresetControl,
      required this.onCreateGroupControl,
      required this.onCreateSequenceControl,
      required this.onAddControlForExisting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controlNodes = nodes.where((node) => isControlNode(node));
    var colorPresets = presets.colors;
    var intensityPresets = presets.intensities;
    var positionPresets = presets.positions;
    var shutterPresets = presets.shutters;

    return PopupMenu<dynamic>(
        categories: [
          PopupCategory(label: "New".i18n, items: [
            PopupItem(ControlType.BUTTON, "Button".i18n),
            PopupItem(ControlType.FADER, "Fader".i18n),
            PopupItem(ControlType.LABEL, "Label".i18n),
          ]),
          if (controlNodes.isNotEmpty)
            PopupCategory(
                label: "Control Nodes".i18n,
                items: controlNodes.map((node) => PopupItem(node, node.path)).toList()),
          if (sequences.isNotEmpty)
            PopupCategory(
                label: "Sequences".i18n,
                items: sequences.map((e) => PopupItem(SequenceId(e.id), e.name)).toList()),
          if (groups.isNotEmpty)
            PopupCategory(
                label: "Groups".i18n,
                items: groups.map((e) => PopupItem(GroupId(e.id), e.name)).toList()),
          if (colorPresets.isNotEmpty)
            PopupCategory(
                label: "Colors".i18n,
                items: colorPresets.map((e) => PopupItem(e.id, e.label)).toList()),
          if (intensityPresets.isNotEmpty)
            PopupCategory(
                label: "Intensities".i18n,
                items: intensityPresets.map((e) => PopupItem(e.id, e.label)).toList()),
          if (shutterPresets.isNotEmpty)
            PopupCategory(
                label: "Shutters".i18n,
                items: shutterPresets.map((e) => PopupItem(e.id, e.label)).toList()),
          if (positionPresets.isNotEmpty)
            PopupCategory(
                label: "Positions".i18n,
                items: positionPresets.map((e) => PopupItem(e.id, e.label)).toList()),
        ],
        onSelect: (value) {
          if (value is ControlType) {
            this.onCreateControl(value);
          } else if (value is PresetId) {
            this.onCreatePresetControl(value);
          } else if (value is GroupId) {
            this.onCreateGroupControl(value.id);
          } else if (value is SequenceId) {
            this.onCreateSequenceControl(value.id);
          } else {
            this.onAddControlForExisting(value);
          }
        });
  }
}

List<String> CONTROL_NODES = [
  "fader",
  "button",
  "label",
];

bool isControlNode(Node node) {
  return CONTROL_NODES.contains(node.type);
}

class SequenceId {
  final int id;

  SequenceId(this.id);
}

class GroupId {
  final int id;

  GroupId(this.id);
}

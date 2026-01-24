import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/dialogs/name_dialog.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/widgets/platform/context_menu.dart';
import 'package:provider/provider.dart';

import 'package:mizer/views/layout/controls/button.dart';
import 'package:mizer/views/layout/controls/dial.dart';
import 'package:mizer/views/layout/controls/fader.dart';
import 'package:mizer/views/layout/controls/group.dart';
import 'package:mizer/views/layout/controls/label.dart';
import 'package:mizer/views/layout/controls/preset.dart';
import 'package:mizer/views/layout/controls/sequencer.dart';
import 'package:mizer/views/layout/controls/timecode.dart';
import 'dialogs/delete_control_dialog.dart';
import 'dialogs/edit_control_dialog.dart';
import 'dialogs/edit_sequencer_control_behavior_dialog.dart';

class LayoutControlView extends StatefulWidget {
  final LayoutsRefPointer pointer;
  final LayoutControl control;
  final String layoutId;
  final Map<int, SequenceState> sequencerState;
  final void Function() onMove;
  final void Function() onResize;

  LayoutControlView(this.pointer, this.layoutId, this.control, this.sequencerState,
      {required this.onMove, required this.onResize});

  @override
  State<LayoutControlView> createState() => _LayoutControlViewState();
}

class _LayoutControlViewState extends State<LayoutControlView> {
  MemoryImage? _image;

  @override
  void initState() {
    super.initState();
    this._image = widget.control.decoration.hasImage
        ? MemoryImage(Uint8List.fromList(widget.control.decoration.image_4))
        : null;
  }

  @override
  void didUpdateWidget(LayoutControlView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.control.decoration.image_4 != widget.control.decoration.image_4) {
      this._image = widget.control.decoration.hasImage
          ? MemoryImage(Uint8List.fromList(widget.control.decoration.image_4))
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    NodesBloc nodes = context.watch();
    NodesApi nodesApi = context.read();
    Node? node =
        this.widget.control.hasNode() ? nodes.getNodeByPath(this.widget.control.node.path) : null;

    var control = _getControl(node, nodesApi);

    if (control == null) {
      return Container();
    }

    var supportsMappings = node?.type == "button" || node?.type == "fader";
    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename".i18n, action: () => _renameControl(context)),
        MenuItem(label: "Edit".i18n, action: () => _editControl(context)),
        MenuItem(label: "Move".i18n, action: () => widget.onMove()),
        MenuItem(label: "Resize".i18n, action: () => widget.onResize()),
        MenuItem(label: "Delete".i18n, action: () => _deleteControl(context)),
        if (widget.control.hasSequencer())
          MenuItem(label: "Behavior".i18n, action: () => _editSequencerBehavior(context)),
        if (supportsMappings) MenuDivider(),
        if (supportsMappings)
          SubMenu(title: "Mappings".i18n, children: [
            MenuItem(label: "Add MIDI Mapping".i18n, action: () => _addMappingForControl(context))
          ]),
      ]),
      child: RepaintBoundary(child: _getControl(node, nodesApi)),
    );
  }

  Widget? _getControl(Node? node, NodesApi apiClient) {
    if (widget.control.hasSequencer()) {
      return SequencerControl(
        label: widget.control.label,
        color: _color,
        sequenceId: widget.control.sequencer.sequenceId,
        state: widget.sequencerState,
        size: widget.control.size,
        behavior: widget.control.behavior.sequencer,
      );
    }
    if (widget.control.hasGroup()) {
      return GroupControl(
        label: widget.control.label,
        color: _color,
        groupId: widget.control.group.groupId,
        size: widget.control.size,
      );
    }
    if (widget.control.hasPreset()) {
      return PresetControl(
        label: widget.control.label,
        color: _color,
        presetId: widget.control.preset.presetId,
        size: widget.control.size,
      );
    }
    if (node?.type == "fader") {
      return FaderControl(pointer: widget.pointer, control: widget.control, color: _color);
    } else if (node?.type == "dial") {
      return DialControl(pointer: widget.pointer, control: widget.control, color: _color);
    } else if (node?.type == "button") {
      return ButtonControl(
        pointer: widget.pointer,
        control: widget.control,
        color: _color,
        image: _image,
        size: widget.control.size,
      );
    } else if (node?.type == "label") {
      return LabelControl(pointer: widget.pointer, control: widget.control, color: _color);
    } else if (node?.type == "timecode") {
      return TimecodeControl(pointer: widget.pointer, control: widget.control, color: _color);
    }
    return null;
  }

  _editControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    ControlDecorations? result = await showDialog(
        context: context, builder: (context) => EditControlDialog(control: widget.control));
    if (result != null) {
      bloc.add(UpdateControlDecoration(
          layoutId: widget.layoutId, controlId: widget.control.id, decorations: result));
    }
  }

  _renameControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    String? result = await showDialog(
        context: context, builder: (context) => NameDialog(name: widget.control.label));
    if (result != null) {
      bloc.add(
          RenameControl(layoutId: widget.layoutId, controlId: widget.control.id, name: result));
    }
  }

  _deleteControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) => DeleteControlDialog(control: widget.control));
    if (result) {
      bloc.add(DeleteControl(layoutId: widget.layoutId, controlId: widget.control.id));
    }
  }

  Color? get _color {
    return widget.control.decoration.hasColor
        ? widget.control.decoration.color_2.asFlutterColor
        : null;
  }

  _addMappingForControl(BuildContext context) async {
    var request = MappingRequest(
      layoutControl: LayoutControlAction(controlNode: widget.control.node.path),
    );
    await addMidiMapping(
        context,
        "Add MIDI Mapping for Control ${widget.control.label.isNotEmpty ? widget.control.label : widget.control.node}",
        request);
  }

  _editSequencerBehavior(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    SequencerControlBehavior? result = await showDialog(
        context: context,
        builder: (context) => EditSequencerControlBehaviorDialog(control: widget.control));
    if (result != null) {
      bloc.add(UpdateControlBehavior(
          layoutId: widget.layoutId,
          controlId: widget.control.id,
          behavior: ControlBehavior(sequencer: result)));
    }
  }
}

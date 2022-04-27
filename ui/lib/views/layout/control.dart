import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/widgets/inputs/button.dart';
import 'package:mizer/widgets/platform/context_menu.dart';

import 'controls/fader.dart';
import 'controls/sequencer.dart';
import 'dialogs/delete_control_dialog.dart';
import 'dialogs/edit_control_dialog.dart';
import 'dialogs/rename_control_dialog.dart';

class LayoutControlView extends StatelessWidget {
  final LayoutControl control;
  final String layoutId;
  final Map<int, SequenceState> sequencerState;
  final void Function() onMove;

  LayoutControlView(this.layoutId, this.control, this.sequencerState, this.onMove);

  @override
  Widget build(BuildContext context) {
    NodesBloc nodes = context.watch();
    NodesApi nodesApi = context.read();
    Node? node = nodes.getNodeByPath(this.control.node);

    var control = _getControl(node, nodesApi);

    if (control == null) {
      return Container();
    }

    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename", action: () => _renameControl(context)),
        MenuItem(label: "Edit", action: () => _editControl(context)),
        MenuItem(label: "Move", action: () => onMove()),
        MenuItem(label: "Delete", action: () => _deleteControl(context)),
      ]),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: _getControl(node, nodesApi),
      ),
    );
  }

  Widget? _getControl(Node? node, NodesApi apiClient) {
    if (node?.type == Node_NodeType.Fader) {
      return FaderControl(control: control, color: _color);
    } else if (node?.type == Node_NodeType.Button) {
      return ButtonInput(
          label: control.label,
          color: _color,
          onValue: (value) =>
              apiClient.writeControlValue(path: control.node, port: "value", value: value));
    } else if (node?.type == Node_NodeType.Sequencer) {
      return SequencerControl(
        label: control.label,
        color: _color,
        node: node!,
        state: sequencerState,
        size: control.size,
      );
    }
    return null;
  }

  _editControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    ControlDecorations? result = await showDialog(
        context: context, builder: (context) => EditControlDialog(control: control));
    if (result != null) {
      bloc.add(UpdateControl(layoutId: layoutId, controlId: control.node, decorations: result));
    }
  }

  _renameControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    String? result = await showDialog(
        context: context, builder: (context) => RenameControlDialog(name: control.label));
    if (result != null) {
      bloc.add(RenameControl(layoutId: layoutId, controlId: control.node, name: result));
    }
  }

  _deleteControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    bool result = await showDialog(
        context: context, builder: (BuildContext context) => DeleteControlDialog(control: control));
    if (result) {
      bloc.add(DeleteControl(layoutId: layoutId, controlId: control.node));
    }
  }

  Color? get _color {
    return control.decoration.hasColor ? control.decoration.color_2.asFlutterColor : null;
  }
}

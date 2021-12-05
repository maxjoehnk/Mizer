import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/extensions/color_extensions.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/widgets/inputs/button.dart';
import 'package:mizer/widgets/inputs/fader.dart';
import 'package:mizer/widgets/platform/context_menu.dart';

import 'controls/sequencer.dart';
import 'delete_control_dialog.dart';
import 'edit_control_dialog.dart';
import 'rename_control_dialog.dart';

class LayoutControlView extends StatelessWidget {
  final LayoutControl control;
  final String layoutId;

  LayoutControlView(this.layoutId, this.control);

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
        // TODO: implement moving of controls
        MenuItem(label: "Move"),
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
      return FaderInput(
        label: control.label,
        color: _color,
        value: 0,
        onValue: (value) =>
            apiClient.writeControlValue(path: control.node, port: "value", value: value),
      );
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
      );
    }
    return null;
  }

  _editControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    ControlDecorations result = await showDialog(
        context: context, builder: (context) => EditControlDialog(control: control));
    if (result != null) {
      bloc.add(UpdateControl(layoutId: layoutId, controlId: control.node, decorations: result));
    }
  }

  _renameControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    String result = await showDialog(
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

  get _color {
    return control.decoration.hasColor ? control.decoration.color_2.asFlutterColor : null;
  }
}

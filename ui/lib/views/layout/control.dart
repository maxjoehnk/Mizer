import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/widgets/inputs/button.dart';
import 'package:mizer/widgets/inputs/fader.dart';
import 'package:mizer/widgets/platform/context_menu.dart';

class LayoutControlView extends StatelessWidget {
  final LayoutControl control;
  final String layoutId;

  LayoutControlView(this.layoutId, this.control);

  @override
  Widget build(BuildContext context) {
    NodesBloc nodes = context.watch();
    NodesApi nodesApi = context.read();
    Node node = nodes.getNodeByPath(this.control.node);

    var control = _getControl(node, nodesApi);

    if (control == null) {
      return Container();
    }

    return ContextMenu(
      menu: Menu(items: [
        MenuItem(label: "Rename", action: () => _renameControl(context)),
        // TODO: implement moving of controls
        MenuItem(label: "Move"),
        MenuItem(label: "Delete", action: () => _deleteControl(context))
      ]),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: _getControl(node, nodesApi),
      ),
    );
  }

  Widget _getControl(Node node, NodesApi apiClient) {
    if (node?.type == Node_NodeType.Fader) {
      return FaderInput(
        label: control.label,
        onValue: (value) =>
            apiClient.writeControlValue(path: control.node, port: "value", value: value),
      );
    } else if (node?.type == Node_NodeType.Button) {
      return ButtonInput(
          label: control.label,
          onValue: (value) =>
              apiClient.writeControlValue(path: control.node, port: "value", value: value));
    }
    return null;
  }

  _renameControl(BuildContext context) async {
    LayoutsBloc bloc = context.read();
    String result = await showDialog(
        context: context, builder: (context) => NameControlDialog(name: control.label));
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
}

class NameControlDialog extends StatelessWidget {
  final String name;
  final TextEditingController nameController;

  NameControlDialog({this.name, Key key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Rename Control"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: Text("Rename"))
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
        ));
  }
}

class DeleteControlDialog extends StatelessWidget {
  final LayoutControl control;

  const DeleteControlDialog({this.control, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Control"),
      content: SingleChildScrollView(
        child: Text("Delete Control ${control.label ?? control.node}?"),
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
    );
  }
}

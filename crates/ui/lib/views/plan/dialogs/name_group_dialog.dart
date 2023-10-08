import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class NameGroupDialog extends StatelessWidget {
  final String? name;
  final TextEditingController nameController;

  NameGroupDialog({this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: name != null ? "Rename Group" : "Add Group",
        actions: [
          PopupAction(
            name != null ? "Rename" : "Add",
            () => Navigator.of(context).pop(nameController.text),
          )
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
          onSubmitted: (text) => Navigator.of(context).pop(text),
        ));
  }
}

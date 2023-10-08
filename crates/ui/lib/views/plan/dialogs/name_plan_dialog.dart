import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class NamePlanDialog extends StatelessWidget {
  final String? name;
  final TextEditingController nameController;

  NamePlanDialog({this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: name != null ? "Rename 2D Plan" : "Add 2D Plan",
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

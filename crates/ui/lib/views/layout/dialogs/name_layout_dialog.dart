import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class NameLayoutDialog extends StatelessWidget {
  final String? name;
  final TextEditingController nameController;

  NameLayoutDialog({this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: name != null ? "Rename Layout".i18n : "Add Layout".i18n,
        actions: [
          PopupAction(name != null ? "Rename".i18n : "Add".i18n,
              () => Navigator.of(context).pop(nameController.text)),
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
          onSubmitted: (text) => Navigator.of(context).pop(text),
        ));
  }
}

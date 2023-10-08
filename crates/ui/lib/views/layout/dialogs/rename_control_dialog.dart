import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class RenameControlDialog extends StatelessWidget {
  final String name;
  final TextEditingController nameController;

  RenameControlDialog({required this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Rename Control".i18n,
        actions: [PopupAction("Rename".i18n, () => Navigator.of(context).pop(nameController.text))],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name".i18n),
          onSubmitted: (text) => Navigator.of(context).pop(text),
        ));
  }
}

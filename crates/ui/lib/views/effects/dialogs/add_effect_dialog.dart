import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class AddEffectDialog extends StatefulWidget {
  AddEffectDialog({Key? key}) : super(key: key);

  @override
  State<AddEffectDialog> createState() => _AddEffectDialogState();
}

class _AddEffectDialogState extends State<AddEffectDialog> {
  final TextEditingController nameController;

  _AddEffectDialogState() : nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Add Effect".i18n,
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name".i18n),
        ),
        actions: [
          PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
          PopupAction("Save".i18n, () {
            Navigator.of(context).pop(nameController.text);
          }),
        ],
    );
  }
}

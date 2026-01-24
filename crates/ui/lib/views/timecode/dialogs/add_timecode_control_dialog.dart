import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class AddTimecodeControlDialog extends StatefulWidget {
  AddTimecodeControlDialog({Key? key}) : super(key: key);

  @override
  State<AddTimecodeControlDialog> createState() => _AddTimecodeControlDialogState();
}

class _AddTimecodeControlDialogState extends State<AddTimecodeControlDialog> {
  final TextEditingController nameController;

  _AddTimecodeControlDialogState() : nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Add Timecode Control".i18n,
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

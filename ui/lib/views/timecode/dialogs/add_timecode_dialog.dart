import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class AddTimecodeDialog extends StatefulWidget {
  AddTimecodeDialog({Key? key}) : super(key: key);

  @override
  State<AddTimecodeDialog> createState() => _AddTimecodeDialogState();
}

class _AddTimecodeDialogState extends State<AddTimecodeDialog> {
  final TextEditingController nameController;

  _AddTimecodeDialogState() : nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Add Timecode".i18n,
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name".i18n),
        ),
        actions: [
          PopupAction("Cancel", () => Navigator.of(context).pop()),
          PopupAction("Save", () {
            Navigator.of(context).pop(nameController.text);
          }),
        ],
    );
  }
}

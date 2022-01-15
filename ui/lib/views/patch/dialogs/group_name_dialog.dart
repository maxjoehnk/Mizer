import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class GroupNameDialog extends StatefulWidget {
  const GroupNameDialog({Key? key}) : super(key: key);

  @override
  State<GroupNameDialog> createState() => _GroupNameDialogState();
}

class _GroupNameDialogState extends State<GroupNameDialog> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Enter Group Name",
      content: TextField(
        controller: nameController,
        autofocus: true,
        decoration: InputDecoration(labelText: "Name"),
      ),
      actions: [
        DialogAction("Confirm", () => _close(context, name: nameController.text)),
        DialogAction("Cancel", () => _close(context)),
      ],
    );
  }

  void _close(BuildContext context, { String? name }) {
    Navigator.of(context).pop(name);
  }
}

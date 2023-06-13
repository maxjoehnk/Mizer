import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class GroupNameDialog extends StatefulWidget {
  String? name;

  GroupNameDialog({this.name, Key? key}) : super(key: key);

  @override
  State<GroupNameDialog> createState() => _GroupNameDialogState();
}

class _GroupNameDialogState extends State<GroupNameDialog> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Enter Group Name",
      content: TextField(
        controller: nameController,
        autofocus: true,
        decoration: InputDecoration(labelText: "Name"),
        onSubmitted: (value) => _close(context, name: value),
      ),
      actions: [
        PopupAction("Confirm", () => _close(context, name: nameController.text)),
        PopupAction("Cancel", () => _close(context)),
      ],
    );
  }

  void _close(BuildContext context, {String? name}) {
    Navigator.of(context).pop(name);
  }
}

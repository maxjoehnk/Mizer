import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class PresetNameDialog extends StatefulWidget {
  final String? name;

  PresetNameDialog({this.name, Key? key}) : super(key: key);

  @override
  State<PresetNameDialog> createState() => _PresetNameDialogState();
}

class _PresetNameDialogState extends State<PresetNameDialog> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Enter Preset Name",
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

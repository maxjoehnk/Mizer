import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class TagNameDialog extends StatefulWidget {
  final String? name;

  TagNameDialog({this.name, Key? key}) : super(key: key);

  @override
  State<TagNameDialog> createState() => _TagNameDialogState();
}

class _TagNameDialogState extends State<TagNameDialog> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Enter Tag Name".i18n,
      content: TextField(
        controller: nameController,
        autofocus: true,
        decoration: InputDecoration(labelText: "Name".i18n),
        textInputAction: TextInputAction.done,
        onSubmitted: (value) => _close(context, name: value),
      ),
      actions: [
        PopupAction("Confirm".i18n, () => _close(context, name: nameController.text)),
        PopupAction("Cancel".i18n, () => _close(context)),
      ],
    );
  }

  void _close(BuildContext context, {String? name}) {
    Navigator.of(context).pop(name);
  }
}

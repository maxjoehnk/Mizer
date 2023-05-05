import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';

class RenameControlDialog extends StatelessWidget {
  final String name;
  final TextEditingController nameController;

  RenameControlDialog({required this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Rename Control".i18n),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: Text("Rename".i18n))
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name".i18n),
        ));
  }
}

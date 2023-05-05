import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';

class NameLayoutDialog extends StatelessWidget {
  final String? name;
  final TextEditingController nameController;

  NameLayoutDialog({this.name, Key? key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(name != null ? "Rename Layout".i18n : "Add Layout".i18n),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: Text(name != null ? "Rename".i18n : "Add".i18n))
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
          onSubmitted: (text) => Navigator.of(context).pop(text),
        ));
  }
}

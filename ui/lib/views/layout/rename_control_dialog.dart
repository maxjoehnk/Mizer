import 'package:flutter/material.dart';

class RenameControlDialog extends StatelessWidget {
  final String name;
  final TextEditingController nameController;

  RenameControlDialog({this.name, Key key})
      : nameController = TextEditingController(text: name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Rename Control"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(nameController.text),
              child: Text("Rename"))
        ],
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(labelText: "Name"),
        ));
  }
}

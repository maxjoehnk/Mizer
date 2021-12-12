import 'package:flutter/material.dart';
import 'package:mizer/protos/connections.pb.dart';

class AddSacnConnectionDialog extends StatefulWidget {
  const AddSacnConnectionDialog({Key? key}) : super(key: key);

  @override
  State<AddSacnConnectionDialog> createState() => _AddSacnConnectionDialogState();
}

class _AddSacnConnectionDialogState extends State<AddSacnConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;

  _AddSacnConnectionDialogState() : _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Sacn Connection"),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Name"),
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),
        ]),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          autofocus: true,
          child: Text("Create"),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            Navigator.of(context).pop(AddSacnRequest(
              name: _nameController.text,
            ));
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

class ConfigureSacnConnectionDialog extends StatefulWidget {
  const ConfigureSacnConnectionDialog({Key? key}) : super(key: key);

  @override
  State<ConfigureSacnConnectionDialog> createState() => _ConfigureSacnConnectionDialogState();
}

class _ConfigureSacnConnectionDialogState extends State<ConfigureSacnConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;

  _ConfigureSacnConnectionDialogState() : _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Sacn Connection".i18n),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Name".i18n),
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),
        ]),
      ),
      actions: [
        TextButton(
          child: Text("Cancel".i18n),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          autofocus: true,
          child: Text("Create".i18n),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            Navigator.of(context).pop(SacnConfig(
              name: _nameController.text,
            ));
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

class AddArtnetConnectionDialog extends StatefulWidget {
  const AddArtnetConnectionDialog({Key? key}) : super(key: key);

  @override
  State<AddArtnetConnectionDialog> createState() => _AddArtnetConnectionDialogState();
}

class _AddArtnetConnectionDialogState extends State<AddArtnetConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;
  final TextEditingController _hostController;
  final TextEditingController _portController;

  _AddArtnetConnectionDialogState()
      : _nameController = TextEditingController(),
        _hostController = TextEditingController(text: "0.0.0.0"),
        _portController = TextEditingController(text: "6454");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Artnet Connection".i18n),
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
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Host is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Host".i18n),
            controller: _hostController,
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Port is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Port".i18n),
            controller: _portController,
            keyboardType: TextInputType.number,
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
            Navigator.of(context).pop(AddArtnetRequest(
                name: _nameController.text,
                host: _hostController.text,
                port: int.parse(_portController.text)));
          },
        ),
      ],
    );
  }
}

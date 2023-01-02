import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

class ConfigureOscConnectionDialog extends StatefulWidget {
  final OscConnection? config;

  const ConfigureOscConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureOscConnectionDialog> createState() => _ConfigureOscConnectionDialogState();
}

class _ConfigureOscConnectionDialogState extends State<ConfigureOscConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hostController;
  final TextEditingController _outputPortController;
  final TextEditingController _inputPortController;

  _ConfigureOscConnectionDialogState()
      : _hostController = TextEditingController(),
        _outputPortController = TextEditingController(),
        _inputPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      this._hostController.text = widget.config!.outputAddress;
      this._outputPortController.text = widget.config!.outputPort.toString();
      this._inputPortController.text = widget.config!.inputPort.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add OSC Connection".i18n),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Host is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Output Host".i18n),
            controller: _hostController,
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Output Port".i18n),
            controller: _outputPortController,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Input Port".i18n),
            controller: _inputPortController,
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
          child: Text("Save".i18n),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            Navigator.of(context).pop(OscConnection(
              outputAddress: _hostController.text,
              outputPort: int.tryParse(_outputPortController.text.trimToMaybeNull()!)!,
              inputPort: int.tryParse(_inputPortController.text.trimToMaybeNull()!)!,
            ));
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class ConfigureOscConnectionDialog extends StatefulWidget {
  final OscConnection? config;

  const ConfigureOscConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureOscConnectionDialog> createState() => _ConfigureOscConnectionDialogState();
}

class _ConfigureOscConnectionDialogState extends State<ConfigureOscConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;
  final TextEditingController _hostController;
  final TextEditingController _outputPortController;
  final TextEditingController _inputPortController;

  _ConfigureOscConnectionDialogState()
      : _nameController = TextEditingController(),
        _hostController = TextEditingController(),
        _outputPortController = TextEditingController(),
        _inputPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      this._nameController.text = widget.config!.name;
      this._hostController.text = widget.config!.outputAddress;
      this._outputPortController.text = widget.config!.outputPort.toString();
      this._inputPortController.text = widget.config!.inputPort.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: widget.config != null ? "Configure OSC Connection".i18n : "Add OSC Connection".i18n,
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
            autofocus: true,
            textInputAction: TextInputAction.next,
          ),
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
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Output Port is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Output Port".i18n),
            controller: _outputPortController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Input Port is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Input Port".i18n),
            controller: _inputPortController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onConfirm(),
          ),
        ]),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Save".i18n, _onConfirm)
      ],
    );
  }

  _onConfirm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pop(OscConnection(
      name: _nameController.text,
      outputAddress: _hostController.text,
      outputPort: int.tryParse(_outputPortController.text.trimToMaybeNull()!)!,
      inputPort: int.tryParse(_inputPortController.text.trimToMaybeNull()!)!,
    ));
  }
}

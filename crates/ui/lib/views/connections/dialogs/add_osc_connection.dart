import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class ConfigureOscConnectionDialog extends StatefulWidget {
  final OscConnection? config;

  const ConfigureOscConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureOscConnectionDialog> createState() => _ConfigureOscConnectionDialogState();
}

class _ConfigureOscConnectionDialogState extends State<ConfigureOscConnectionDialog> {
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
      content: Column(spacing: FORM_GAP_SIZE, mainAxisSize: MainAxisSize.min, children: [
        Field(
          label: "Name".i18n,
          big: true,
          child: TextInput(
            controller: _nameController,
            autofocus: true,
          ),
        ),
        Field(
          label: "Output Host".i18n,
          big: true,
          child: TextInput(
            controller: _hostController,
          ),
        ),
        Field(
          label: "Output Port".i18n,
          big: true,
          child: TextInput(
            controller: _outputPortController,
          ),
        ),
        Field(
          label: "Input Port".i18n,
          big: true,
          child: TextInput(
            controller: _inputPortController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onConfirm(),
          ),
        ),
      ]),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Save".i18n, _onConfirm)
      ],
    );
  }

  _onConfirm() {
    if (!_validate()) {
      return;
    }
    Navigator.of(context).pop(OscConnection(
      name: _nameController.text,
      outputAddress: _hostController.text,
      outputPort: int.tryParse(_outputPortController.text.trimToMaybeNull()!)!,
      inputPort: int.tryParse(_inputPortController.text.trimToMaybeNull()!)!,
    ));
  }

  bool _validate() {
    if (_nameController.text.isEmpty) {
      return false;
    }
    if (_hostController.text.isEmpty) {
      return false;
    }
    if (_outputPortController.text.isEmpty) {
      return false;
    }
    if (int.tryParse(_outputPortController.text) == null) {
      return false;
    }
    if (_inputPortController.text.isEmpty) {
      return false;
    }
    if (int.tryParse(_inputPortController.text) == null) {
      return false;
    }
    return true;
  }
}

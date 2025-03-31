import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class ConfigureSacnConnectionDialog extends StatefulWidget {
  final SacnConfig? config;

  const ConfigureSacnConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureSacnConnectionDialog> createState() => _ConfigureSacnConnectionDialogState();
}

class _ConfigureSacnConnectionDialogState extends State<ConfigureSacnConnectionDialog> {
  final TextEditingController _nameController;
  final TextEditingController _priorityController;

  _ConfigureSacnConnectionDialogState()
      : _nameController = TextEditingController(),
        _priorityController = TextEditingController(text: "100");

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      this._nameController.text = widget.config!.name;
      this._priorityController.text = widget.config!.priority.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: widget.config != null ? "Configure Sacn Connection".i18n : "Add Sacn Connection".i18n,
      content: Column(spacing: FORM_GAP_SIZE, mainAxisSize: MainAxisSize.min, children: [
        Field(
          label: "Name".i18n,
          big: true,
          child: TextInput(
            controller: _nameController,
            autofocus: true,
            onSubmitted: (_) => _onConfirm(),
          ),
        ),
        Field(
          label: "Priority".i18n,
          big: true,
          child: TextInput(
            controller: _priorityController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onConfirm(),
          ),
        ),
      ]),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Create".i18n, () => _onConfirm()),
      ],
    );
  }

  _onConfirm() {
    if (!_validate()) {
      return;
    }
    Navigator.of(context)
        .pop(SacnConfig(name: _nameController.text, priority: int.parse(_priorityController.text)));
  }

  bool _validate() {
    return _nameController.text.isNotEmpty && _priorityController.text.isNotEmpty && int.tryParse(_priorityController.text) != null;
  }
}

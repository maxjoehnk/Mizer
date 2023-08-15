import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class ConfigureSacnConnectionDialog extends StatefulWidget {
  final SacnConfig? config;

  const ConfigureSacnConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureSacnConnectionDialog> createState() => _ConfigureSacnConnectionDialogState();
}

class _ConfigureSacnConnectionDialogState extends State<ConfigureSacnConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            onFieldSubmitted: (_) => _onConfirm(),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Priority".i18n),
            controller: _priorityController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onConfirm(),
          ),
        ]),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Create".i18n, () => _onConfirm()),
      ],
    );
  }

  _onConfirm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context)
        .pop(SacnConfig(name: _nameController.text, priority: int.parse(_priorityController.text)));
  }
}

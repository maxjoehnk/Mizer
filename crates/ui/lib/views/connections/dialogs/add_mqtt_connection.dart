import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class ConfigureMqttConnectionDialog extends StatefulWidget {
  final MqttConnection? config;

  const ConfigureMqttConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureMqttConnectionDialog> createState() => _ConfigureMqttConnectionDialogState();
}

class _ConfigureMqttConnectionDialogState extends State<ConfigureMqttConnectionDialog> {
  final TextEditingController _urlController;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  _ConfigureMqttConnectionDialogState()
      : _urlController = TextEditingController(text: "mqtt://localhost"),
        _usernameController = TextEditingController(),
        _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      this._urlController.text = widget.config!.url;
      this._usernameController.text = widget.config!.username;
      this._passwordController.text = widget.config!.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: widget.config != null ? "Configure MQTT Connection".i18n : "Add MQTT Connection".i18n,
      content: Column(spacing: FORM_GAP_SIZE, mainAxisSize: MainAxisSize.min, children: [
        Field(
          label: "URL".i18n,
          big: true,
          child: TextInput(
            controller: _urlController,
            autofocus: true,
          ),
        ),
        Field(
          label: "Username".i18n,
          big: true,
          child: TextInput(
            controller: _usernameController,
          ),
        ),
        Field(
          label: "Password".i18n,
          big: true,
          child: TextInput(
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onConfirm(),
          ),
        ),
      ]),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Save", () => _onConfirm()),
      ],
    );
  }

  _onConfirm() {
    if (!_validate()) {
      return;
    }
    Navigator.of(context).pop(MqttConnection(
      url: _urlController.text,
      username: _usernameController.text.trimToMaybeNull(),
      password: _passwordController.text.trimToMaybeNull(),
    ));
  }

  bool _validate() {
    if (_urlController.text.isEmpty) {
      return false;
    }
    return true;
  }
}

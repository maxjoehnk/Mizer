import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class ConfigureMqttConnectionDialog extends StatefulWidget {
  final MqttConnection? config;

  const ConfigureMqttConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureMqttConnectionDialog> createState() => _ConfigureMqttConnectionDialogState();
}

class _ConfigureMqttConnectionDialogState extends State<ConfigureMqttConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Url is required'.i18n;
              }
              return null;
            },
            decoration: InputDecoration(labelText: "URL".i18n),
            controller: _urlController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autofocus: true,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Username".i18n),
            controller: _usernameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password".i18n),
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onConfirm(),
          ),
        ]),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Save", () => _onConfirm())
      ],
    );
  }

  _onConfirm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pop(MqttConnection(
      url: _urlController.text,
      username: _usernameController.text.trimToMaybeNull(),
      password: _passwordController.text.trimToMaybeNull(),
    ));
  }
}

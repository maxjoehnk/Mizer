import 'package:flutter/material.dart';
import 'package:mizer/extensions/string_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';

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
    return AlertDialog(
      title: Text("Add MQTT Connection".i18n),
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
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Username".i18n),
            controller: _usernameController,
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password".i18n),
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
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
            Navigator.of(context).pop(MqttConnection(
              url: _urlController.text,
              username: _usernameController.text.trimToMaybeNull(),
              password: _passwordController.text.trimToMaybeNull(),
            ));
          },
        ),
      ],
    );
  }
}

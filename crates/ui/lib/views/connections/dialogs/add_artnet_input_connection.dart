import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class ConfigureArtnetInputConnectionDialog extends StatefulWidget {
  final ArtnetInputConfig? config;

  const ConfigureArtnetInputConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureArtnetInputConnectionDialog> createState() =>
      _ConfigureArtnetInputConnectionDialogState();
}

class _ConfigureArtnetInputConnectionDialogState
    extends State<ConfigureArtnetInputConnectionDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;
  final TextEditingController _hostController;
  final TextEditingController _portController;

  _ConfigureArtnetInputConnectionDialogState()
      : _nameController = TextEditingController(),
        _hostController = TextEditingController(text: "0.0.0.0"),
        _portController = TextEditingController(text: "6454");

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      this._nameController.text = widget.config!.name;
      this._hostController.text = widget.config!.host;
      this._portController.text = widget.config!.port.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: widget.config != null
          ? "Configure Artnet Input Connection".i18n
          : "Add Artnet Input Connection".i18n,
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
            decoration: InputDecoration(labelText: "Host".i18n),
            controller: _hostController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
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
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onCreate(),
          ),
        ]),
      ),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("Create", _onCreate)
      ],
    );
  }

  _onCreate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Navigator.of(context).pop(ArtnetInputConfig(
        name: _nameController.text,
        host: _hostController.text,
        port: int.parse(_portController.text)));
  }
}

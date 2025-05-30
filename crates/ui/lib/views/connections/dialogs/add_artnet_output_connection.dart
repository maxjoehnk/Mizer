import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class ConfigureArtnetOutputConnectionDialog extends StatefulWidget {
  final ArtnetOutputConfig? config;

  const ConfigureArtnetOutputConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureArtnetOutputConnectionDialog> createState() =>
      _ConfigureArtnetOutputConnectionDialogState();
}

class _ConfigureArtnetOutputConnectionDialogState
    extends State<ConfigureArtnetOutputConnectionDialog> {
  final TextEditingController _nameController;
  final TextEditingController _hostController;
  final TextEditingController _portController;

  _ConfigureArtnetOutputConnectionDialogState()
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
          ? "Configure Artnet Output Connection".i18n
          : "Add Artnet Output Connection".i18n,
      content: Column(spacing: FORM_GAP_SIZE, mainAxisSize: MainAxisSize.min, children: [
        Field(
          label: "Name",
          big: true,
          child: TextInput(
            controller: _nameController,
            autofocus: true,
            textInputAction: TextInputAction.next,
          ),
        ),
        Field(
          label: "Host",
          big: true,
          child: TextInput(
            controller: _hostController,
            textInputAction: TextInputAction.next,
          ),
        ),
        Field(
          label: "Port",
          big: true,
          child: TextInput(
            controller: _portController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onCreate(),
          ),
        ),
      ]),
      actions: [
        PopupAction("Cancel", () => Navigator.of(context).pop()),
        PopupAction("Create", _onCreate)
      ],
    );
  }

  _onCreate() {
    if (!_validate()) {
      return;
    }
    Navigator.of(context).pop(ArtnetOutputConfig(
        name: _nameController.text,
        host: _hostController.text,
        port: int.parse(_portController.text)));
  }

  bool _validate() {
    if (_nameController.text.isEmpty) {
      return false;
    }
    if (_hostController.text.isEmpty) {
      return false;
    }
    if (_portController.text.isEmpty) {
      return false;
    }
    if (int.tryParse(_portController.text) == null) {
      return false;
    }
    return true;
  }
}

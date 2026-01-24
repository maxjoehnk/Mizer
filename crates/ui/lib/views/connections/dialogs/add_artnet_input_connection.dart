import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/widgets/field/text_input.dart';

class ConfigureArtnetInputConnectionDialog extends StatefulWidget {
  final ArtnetInputConfig? config;

  const ConfigureArtnetInputConnectionDialog({this.config, Key? key}) : super(key: key);

  @override
  State<ConfigureArtnetInputConnectionDialog> createState() =>
      _ConfigureArtnetInputConnectionDialogState();
}

class _ConfigureArtnetInputConnectionDialogState
    extends State<ConfigureArtnetInputConnectionDialog> {
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
      content: Column(spacing: FORM_GAP_SIZE, mainAxisSize: MainAxisSize.min, children: [
        Field(
          label: "Name".i18n,
          big: true,
          child: TextInput(
            autofocus: true,
            controller: _nameController,
          )
        ),
        Field(
            label: "Host".i18n,
            big: true,
            child: TextInput(
              controller: _hostController,
            )
        ),
        Field(
            label: "Port".i18n,
            big: true,
            child: TextInput(
              controller: _portController,
              textInputAction: TextInputAction.done,
            )
        ),
      ]),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        PopupAction("Create".i18n, _onCreate)
      ],
    );
  }

  _onCreate() {
    if (!_validate()) {
      return;
    }
    Navigator.of(context).pop(ArtnetInputConfig(
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

import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

import 'package:mizer/mobile/session_selector.dart';

const int defaultPort = 50000;

class DirectConnectDialog extends StatefulWidget {
  const DirectConnectDialog({super.key});

  @override
  State<DirectConnectDialog> createState() => _DirectConnectDialogState();
}

class _DirectConnectDialogState extends State<DirectConnectDialog> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController(text: defaultPort.toString());

  @override
  Widget build(BuildContext context) {
    return ActionDialog(title: "Direct Connect", content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextFormField(
        decoration: InputDecoration(labelText: "Host", border: OutlineInputBorder()),
        autofocus: true,
        controller: _hostController,
      ),
      SizedBox(height: 8),
      TextFormField(
        decoration: InputDecoration(labelText: "Port", border: OutlineInputBorder()),
        controller: _portController,
        keyboardType: TextInputType.number,
      ),
    ]), actions: [
      PopupAction(
        "Cancel",
        () => Navigator.of(context).pop()
      ),
      PopupAction(
        "Connect",
        () {
          var address = _hostController.text;
          var port = int.tryParse(_portController.text) ?? defaultPort;
          var host = Host(address, address, port);

          Navigator.of(context).pop(Session(host));
        }
      ),
    ]);
  }
}

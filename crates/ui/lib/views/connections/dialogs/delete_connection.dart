import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeleteConnectionDialog extends StatelessWidget {
  final Connection connection;

  const DeleteConnectionDialog({super.key, required this.connection});

  static Future<bool?> show(BuildContext context, Connection connection) async {
    return showDialog(
      context: context,
      builder: (context) => DeleteConnectionDialog(connection: connection),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Delete Connection".i18n,
      content: SingleChildScrollView(
        child: Text("Delete Connection ${connection.name}?".i18n),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop(false)),
        PopupAction("Delete".i18n, () => Navigator.of(context).pop(true)),
      ],
      onConfirm: () => Navigator.of(context).pop(true),
    );
  }
}

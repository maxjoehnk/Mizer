import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeleteLayoutDialog extends StatelessWidget {
  final Layout layout;

  const DeleteLayoutDialog({super.key, required this.layout});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      onConfirm: () => Navigator.of(context).pop(true),
      title: "Delete Layout".i18n,
      content: SingleChildScrollView(
        child: Text("Delete Layout ${layout.id}?".i18n),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop(false)),
        PopupAction("Delete".i18n, () => Navigator.of(context).pop(true)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeleteFixtureDialog extends StatelessWidget {
  const DeleteFixtureDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Delete Fixture".i18n,
      actions: [
        PopupAction("Confirm".i18n, () => _close(context, true)),
        PopupAction("Cancel".i18n, () => _close(context, false)),
      ],
      onConfirm: () => _close(context, true),
    );
  }

  void _close(BuildContext context, bool confirmation) {
    Navigator.of(context).pop(confirmation);
  }
}

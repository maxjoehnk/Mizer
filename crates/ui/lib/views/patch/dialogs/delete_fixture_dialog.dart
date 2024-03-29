import 'package:flutter/material.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeleteFixtureDialog extends StatelessWidget {
  const DeleteFixtureDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Delete Fixture",
      actions: [
        PopupAction("Confirm", () => _close(context, true)),
        PopupAction("Cancel", () => _close(context, false)),
      ],
      onConfirm: () => _close(context, true),
    );
  }

  void _close(BuildContext context, bool confirmation) {
    Navigator.of(context).pop(confirmation);
  }
}

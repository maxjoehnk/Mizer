import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeleteControlDialog extends StatelessWidget {
  final LayoutControl control;

  const DeleteControlDialog({required this.control, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      onConfirm: () => Navigator.of(context).pop(true),
      title: "Delete Control".i18n,
      content: SingleChildScrollView(
        child: Text("Delete Control {label}?".i18n.args({ "label": control.hasLabel() ? control.label : control.node })),
      ),
      actions: [
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop(false)),
        PopupAction("Delete".i18n, () => Navigator.of(context).pop(true)),
      ],
    );
  }
}

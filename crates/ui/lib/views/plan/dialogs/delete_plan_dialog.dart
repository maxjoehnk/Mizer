import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeletePlanDialog extends StatelessWidget {
  final Plan plan;

  const DeletePlanDialog({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Delete Plan".i18n,
      onConfirm: () => Navigator.of(context).pop(true),
      content: SingleChildScrollView(
        child: Text("Delete Plan {name}".i18n.args({ "name": plan.name })),
      ),
      actions: [
        PopupAction(
          "Cancel".i18n,
          () => Navigator.of(context).pop(false),
        ),
        PopupAction(
          "Delete".i18n,
          () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

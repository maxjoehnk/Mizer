import 'package:flutter/material.dart';
import 'package:mizer/protos/plans.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class DeletePlanDialog extends StatelessWidget {
  final Plan plan;

  const DeletePlanDialog({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Delete Plan",
      onConfirm: () => Navigator.of(context).pop(true),
      content: SingleChildScrollView(
        child: Text("Delete Plan ${plan.name}?"),
      ),
      actions: [
        PopupAction(
          "Cancel",
          () => Navigator.of(context).pop(false),
        ),
        PopupAction(
          "Delete",
          () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

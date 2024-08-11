import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class GroupStoreModeDialog extends StatelessWidget {
  const GroupStoreModeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Store",
      content: Text("Please choose store mode"),
      actions: [
        PopupAction("Overwrite", () => _close(context, StoreGroupMode.STORE_GROUP_MODE_OVERWRITE)),
        PopupAction("Merge", () => _close(context, StoreGroupMode.STORE_GROUP_MODE_MERGE)),
        PopupAction("Subtract", () => _close(context, StoreGroupMode.STORE_GROUP_MODE_SUBTRACT)),
        PopupAction("Cancel", () => Navigator.of(context).pop()),
      ],
    );
  }

  void _close(BuildContext context, StoreGroupMode mode) {
    Navigator.of(context).pop(mode);
  }
}

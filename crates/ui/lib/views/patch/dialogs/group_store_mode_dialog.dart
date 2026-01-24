import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class GroupStoreModeDialog extends StatelessWidget {
  const GroupStoreModeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Store".i18n,
      content: Text("Please choose store mode".i18n),
      actions: [
        PopupAction("Overwrite".i18n, () => _close(context, StoreGroupMode.STORE_GROUP_MODE_OVERWRITE)),
        PopupAction("Merge".i18n, () => _close(context, StoreGroupMode.STORE_GROUP_MODE_MERGE)),
        PopupAction("Subtract".i18n, () => _close(context, StoreGroupMode.STORE_GROUP_MODE_SUBTRACT)),
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
      ],
    );
  }

  void _close(BuildContext context, StoreGroupMode mode) {
    Navigator.of(context).pop(mode);
  }
}

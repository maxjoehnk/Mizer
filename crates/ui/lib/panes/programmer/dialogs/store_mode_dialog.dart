import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/i18n.dart';

class StoreModeDialog extends StatelessWidget {
  const StoreModeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Store".i18n,
      content: Text("Please choose store mode".i18n),
      actions: [
        PopupAction("Overwrite".i18n, () => _close(context, StoreRequest_Mode.OVERWRITE)),
        PopupAction("Merge".i18n, () => _close(context, StoreRequest_Mode.MERGE)),
        PopupAction("Create new Cue".i18n, () => _close(context, StoreRequest_Mode.ADD_CUE)),
        PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
      ],
    );
  }

  void _close(BuildContext context, StoreRequest_Mode mode) {
    Navigator.of(context).pop(mode);
  }
}

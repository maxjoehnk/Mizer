import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class StoreModeDialog extends StatelessWidget {
  const StoreModeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Store",
      content: Text("Please choose store mode"),
      actions: [
        PopupAction("Overwrite", () => _close(context, StoreRequest_Mode.OVERWRITE)),
        PopupAction("Merge", () => _close(context, StoreRequest_Mode.MERGE)),
        PopupAction("Create new Cue", () => _close(context, StoreRequest_Mode.ADD_CUE)),
        PopupAction("Cancel", () => Navigator.of(context).pop()),
      ],
    );
  }

  void _close(BuildContext context, StoreRequest_Mode mode) {
    Navigator.of(context).pop(mode);
  }
}

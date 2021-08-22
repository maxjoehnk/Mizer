import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/programmer.pb.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

class StoreModeDialog extends StatelessWidget {
  const StoreModeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
      title: "Store",
      content: Text("Please choose store mode"),
      actions: [
        DialogAction("Overwrite", () => _close(context, StoreRequest_Mode.Overwrite)),
        DialogAction("Merge", () => _close(context, StoreRequest_Mode.Merge)),
        DialogAction("Create new Cue", () => _close(context, StoreRequest_Mode.AddCue)),
        DialogAction("Cancel", () => Navigator.of(context).pop()),
      ],
    );
  }

  void _close(BuildContext context, StoreRequest_Mode mode) {
    Navigator.of(context).pop(mode);
  }
}

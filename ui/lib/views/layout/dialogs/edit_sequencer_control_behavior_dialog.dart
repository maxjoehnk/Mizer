import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/layouts.pb.dart' hide Color;
import 'package:mizer/widgets/controls/select.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:protobuf/protobuf.dart';

class EditSequencerControlBehaviorDialog extends StatefulWidget {
  final LayoutControl control;

  const EditSequencerControlBehaviorDialog({required this.control, Key? key}) : super(key: key);

  @override
  State<EditSequencerControlBehaviorDialog> createState() =>
      _EditSequencerControlBehaviorDialogState(control.behavior.sequencer.deepCopy());
}

class _EditSequencerControlBehaviorDialogState extends State<EditSequencerControlBehaviorDialog> {
  SequencerControlBehavior behavior;

  _EditSequencerControlBehaviorDialogState(this.behavior);

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Configure Control".i18n,
        actions: [
          PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
          PopupAction("Confirm".i18n, () => Navigator.of(context).pop(behavior))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(flex: 1, child: Text("Click")),
                Flexible(
                  flex: 2,
                  child: MizerSelect<SequencerControlBehavior_ClickBehavior>(
                      value: behavior.clickBehavior,
                      options: [
                        SelectOption(value: SequencerControlBehavior_ClickBehavior.GO_FORWARD, label: "Go+"),
                        SelectOption(value: SequencerControlBehavior_ClickBehavior.TOGGLE, label: "Toggle Playback"),
                      ],
                      onChanged: (clickBehavior) =>
                          setState(() => behavior.clickBehavior = clickBehavior)),
                ),
              ],
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/panes/programmer/dialogs/select_sequence_dialog.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';

enum StoreTarget {
  Group,
  Sequence,
}

const Map<StoreTarget, String> storeTargetNames = {
  StoreTarget.Group: "Group",
  StoreTarget.Sequence: "Sequence",
};

final Map<LogicalKeyboardKey, StoreTarget> storeTargetHotkeys = {
  LogicalKeyboardKey.keyG: StoreTarget.Group,
  LogicalKeyboardKey.keyS: StoreTarget.Sequence,
};

Future<StoreTarget?> selectStoreTarget(BuildContext context) async {
  return await showDialog<StoreTarget>(
      context: context, builder: (context) => SelectStoreTargetDialog());
}

class SelectStoreTargetDialog extends StatefulWidget {
  const SelectStoreTargetDialog({super.key});

  @override
  State<SelectStoreTargetDialog> createState() => _SelectStoreTargetDialogState();
}

class _SelectStoreTargetDialogState extends State<SelectStoreTargetDialog> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Store",
        content: KeyboardListener(
          autofocus: true,
          onKeyEvent: (event) {
            var target = storeTargetHotkeys[event.logicalKey];
            if (target == null) {
              return;
            }
            _select(context, target);
          },
          focusNode: _focusNode,
          child: Wrap(
              spacing: 4,
              runSpacing: 4,
              direction: Axis.horizontal,
              children: StoreTarget.values
                  .map((target) =>
                      StoreTargetTile(target: target, onSelect: () => _select(context, target)))
                  .toList()),
        ),
        actions: [
          PopupAction("Cancel", () => Navigator.of(context).pop()),
        ]);
  }

  _select(BuildContext context, StoreTarget storeTarget) {
    Navigator.of(context).pop(storeTarget);
  }
}

class StoreTargetTile extends StatelessWidget {
  final StoreTarget target;
  final Function() onSelect;

  const StoreTargetTile({required this.target, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    var name = storeTargetNames[target]!;
    return Tile(child: Center(child: RichText(text: _highlightHotkey(name))), onClick: onSelect);
  }

  InlineSpan _highlightHotkey(String text) {
    return TextSpan(
      children: [
        TextSpan(
          text: text[0],
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: text.substring(1)),
      ],
    );
  }
}

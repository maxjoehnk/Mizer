import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/dialog/dialog_tile.dart';
import 'package:mizer/widgets/dialog/grid_dialog.dart';
import 'package:mizer/i18n.dart';

enum StoreTarget {
  Group,
  Sequence,
  Preset,
}

final Map<StoreTarget, String Function()> storeTargetNames = {
  StoreTarget.Group: () => "Group".i18n,
  StoreTarget.Sequence: () => "Sequence".i18n,
  StoreTarget.Preset: () => "Preset".i18n,
};

final Map<LogicalKeyboardKey, StoreTarget> storeTargetHotkeys = {
  LogicalKeyboardKey.keyG: StoreTarget.Group,
  LogicalKeyboardKey.keyS: StoreTarget.Sequence,
  LogicalKeyboardKey.keyP: StoreTarget.Preset,
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
        title: "Store".i18n,
        content: KeyboardListener(
          autofocus: true,
          onKeyEvent: (event) {
            if (!(event is KeyDownEvent)) {
              return;
            }
            var target = storeTargetHotkeys[event.logicalKey];
            if (target == null) {
              return;
            }
            _select(context, target);
          },
          focusNode: _focusNode,
          child: DialogTileGrid(
              columns: 3,
              children: StoreTarget.values
                  .map((target) =>
                      StoreTargetTile(target: target, onSelect: () => _select(context, target)))
                  .toList()),
        ),
        actions: [
          PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
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
    var name = storeTargetNames[target]!();
    return DialogTile(child: Center(child: RichText(text: _highlightHotkey(name))), onClick: onSelect);
  }

  InlineSpan _highlightHotkey(String text) {
    return TextSpan(
      children: [
        TextSpan(
          text: text[0],
          style: TextStyle(
              decoration: TextDecoration.underline, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextSpan(text: text.substring(1), style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

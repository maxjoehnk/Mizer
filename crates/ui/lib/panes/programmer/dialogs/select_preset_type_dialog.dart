import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/dialog/dialog_tile.dart';
import 'package:mizer/widgets/dialog/grid_dialog.dart';
import 'package:mizer/i18n.dart';

enum PresetType { Intensity, Shutter, Color, Position }

final Map<PresetType, String Function()> storeTargetNames = {
  PresetType.Intensity: () => "Intensity".i18n,
  PresetType.Shutter: () => "Shutter".i18n,
  PresetType.Color: () => "Color".i18n,
  PresetType.Position: () => "Position".i18n,
};

final Map<LogicalKeyboardKey, PresetType> storeTargetHotkeys = {
  LogicalKeyboardKey.keyI: PresetType.Intensity,
  LogicalKeyboardKey.keyS: PresetType.Shutter,
  LogicalKeyboardKey.keyC: PresetType.Color,
  LogicalKeyboardKey.keyP: PresetType.Position,
};

Future<PresetType?> selectPresetType(BuildContext context) async {
  return await showDialog<PresetType>(
      context: context, builder: (context) => SelectPresetTypeDialog());
}

class SelectPresetTypeDialog extends StatefulWidget {
  const SelectPresetTypeDialog({super.key});

  @override
  State<SelectPresetTypeDialog> createState() => _SelectPresetTypeDialogState();
}

class _SelectPresetTypeDialogState extends State<SelectPresetTypeDialog> {
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
              columns: 4,
              children: PresetType.values
                  .map((target) =>
                      PresetTypeTile(target: target, onSelect: () => _select(context, target)))
                  .toList()),
        ),
        actions: [
          PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
        ]);
  }

  _select(BuildContext context, PresetType storeTarget) {
    Navigator.of(context).pop(storeTarget);
  }
}

class PresetTypeTile extends StatelessWidget {
  final PresetType target;
  final Function() onSelect;

  const PresetTypeTile({required this.target, required this.onSelect, super.key});

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
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: text.substring(1)),
      ],
    );
  }
}

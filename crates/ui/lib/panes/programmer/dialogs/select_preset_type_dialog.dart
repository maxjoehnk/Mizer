import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/tile.dart';

enum PresetType { Intensity, Shutter, Color, Position }

const Map<PresetType, String> storeTargetNames = {
  PresetType.Intensity: "Intensity",
  PresetType.Shutter: "Shutter",
  PresetType.Color: "Color",
  PresetType.Position: "Position",
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
        title: "Store",
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
          child: Wrap(
              spacing: 4,
              runSpacing: 4,
              direction: Axis.horizontal,
              children: PresetType.values
                  .map((target) =>
                      PresetTypeTile(target: target, onSelect: () => _select(context, target)))
                  .toList()),
        ),
        actions: [
          PopupAction("Cancel", () => Navigator.of(context).pop()),
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

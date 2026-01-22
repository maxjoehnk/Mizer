import 'package:flutter/material.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/text_field.dart';
import 'package:mizer/widgets/hotkey_formatter.dart';
import 'package:mizer/widgets/hotkey_selector/hotkey_selector.dart';

class HotkeySetting extends StatelessWidget {
  final String label;
  final String combination;
  final Function(String?) update;
  final bool resetToDefault;
  final Function()? onResetToDefault;

  const HotkeySetting({required this.label, required this.combination, Key? key, required this.update, this.resetToDefault = false, this.onResetToDefault}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextPropertyField(
      label: label,
      labelWidth: 200,
      value: formatHotkey(combination),
      readOnly: true,
      resetToDefault: resetToDefault,
      onResetToDefault: onResetToDefault,
      actions: [
        FieldAction(
            child: Text("..."),
            onTap: () async {
              var hotkey = await showDialog(context: context, builder: (context) => HotkeySelectorDialog());

              if (hotkey != null) {
                update(hotkey);
              }
            }),
        if (combination.isNotEmpty) FieldAction(
            child: Icon(
              Icons.clear,
              size: 15,
            ),
            onTap: () => this.update(""))
      ]
    );
  }
}

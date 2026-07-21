import 'package:flutter/material.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/theme.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BooleanField extends StatelessWidget {
  final String label;
  final double? labelWidth;
  final bool value;
  final bool vertical;
  final Function(bool) onUpdate;
  final bool resetToDefault;
  final Function()? onResetToDefault;

  BooleanField({required this.label, this.labelWidth, required this.value, this.vertical = false, required this.onUpdate, this.resetToDefault = false, this.onResetToDefault});

  @override
  Widget build(BuildContext context) {
    var mizerTheme = Theme.of(context).mizerTheme;
    return Field(
        label: label,
        labelWidth: labelWidth,
        vertical: vertical,
        resetToDefault: resetToDefault,
        onResetToDefault: onResetToDefault,
        child: Container(
          height: INPUT_FIELD_HEIGHT,
          alignment: vertical ? Alignment.center : Alignment.centerRight,
          padding: const EdgeInsets.all(2),
          child: ToggleSwitch(
            labels: ['On', 'Off'],
            totalSwitches: 2,
            activeBgColors: [
              [mizerTheme.primary],
              [mizerTheme.actionActive]
            ],
            minWidth: 50,
            inactiveBgColor: mizerTheme.actionBackground,
            initialLabelIndex: value ? 0 : 1,
            onToggle: (index) => onUpdate(index == 0),
            changeOnTap: true,
            radiusStyle: true,
            cornerRadius: BORDER_RADIUS,
          ),
        ));
  }
}

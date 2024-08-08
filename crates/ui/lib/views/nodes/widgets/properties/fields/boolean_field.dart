import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'field.dart';

class BooleanField extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onUpdate;

  BooleanField({required this.label, required this.value, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Field(
        label: label,
        child: Container(
          height: 24,
          child: ToggleSwitch(
            labels: ['On', 'Off'],
            totalSwitches: 2,
            activeBgColors: [
              [Colors.deepOrange],
              [Colors.grey.shade700]
            ],
            minWidth: 50,
            inactiveBgColor: Colors.grey.shade800,
            initialLabelIndex: value ? 0 : 1,
            onToggle: (index) => onUpdate(index == 0),
            changeOnTap: true,
            radiusStyle: true,
            cornerRadius: 2,
          ),
        ));
  }
}

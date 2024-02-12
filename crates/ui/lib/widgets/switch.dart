import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MizerSwitch extends StatelessWidget {
  final String? onText;
  final String? offText;
  final bool value;
  final ValueChanged<bool> onChanged;

  const MizerSwitch({super.key, this.onText, this.offText, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ToggleSwitch(
        labels: [onText!, offText!],
        totalSwitches: 2,
        activeBgColors: [[Colors.green.shade700], [Colors.red.shade800]],
        inactiveBgColor: Colors.grey.shade700,
        initialLabelIndex: value ? 0 : 1,
        onToggle: (index) => onChanged(index == 0),
        changeOnTap: true,
        radiusStyle: true,
        cornerRadius: 20,
      ),
    );
  }
}

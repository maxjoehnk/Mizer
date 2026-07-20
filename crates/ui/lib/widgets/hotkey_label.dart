import 'package:flutter/material.dart';
import 'package:mizer/widgets/hotkey_formatter.dart';

class HotkeyLabel extends StatelessWidget {
  final String hotkey;

  const HotkeyLabel({super.key, required this.hotkey});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Text(formatHotkey(hotkey), style: textTheme.bodySmall!.copyWith(fontSize: 12));
  }
}

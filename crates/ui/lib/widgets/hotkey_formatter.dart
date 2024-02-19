import 'dart:io';

import 'package:mizer/extensions/string_extensions.dart';

String formatHotkey(String hotkey) {
  if (Platform.isMacOS) {
    hotkey = hotkey
        .replaceAll('cmd', '⌘')
        .replaceAll('ctrl', '⌃')
        .replaceAll('alt', '⌥')
        .replaceAll('shift', '⇧')
        .replaceAll('backspace', '⌫');
  }

  return hotkey
      .split('+')
      .map((e) => e.toCapitalCase())
      .join('+');
}

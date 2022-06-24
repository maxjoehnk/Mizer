import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:provider/provider.dart';

import 'keymap.dart';

class HotkeyProvider extends StatelessWidget {
  final Map<String, String> Function(Hotkeys) hotkeySelector;
  late final Widget Function(BuildContext, Map<String, String>) builder;
  late final void Function(String) onHotkey;
  late final Map<String, Function()> hotkeyMap;
  final bool global;

  HotkeyProvider(
      {required this.hotkeySelector,
      Widget? child,
      Widget Function(BuildContext, Map<String, String>)? builder,
      Function(String)? onHotkey,
      Map<String, Function()>? hotkeyMap,
      this.global = false}) {
    assert(onHotkey != null || hotkeyMap != null);
    if (child != null) {
      this.builder = (context, hotkeys) => child;
    }
    if (builder != null) {
      this.builder = builder;
    }
    assert(this.builder != null);
    if (hotkeyMap != null) {
      this.onHotkey = (key) {
        var handler = hotkeyMap[key];
        if (handler != null) {
          handler();
        }
      };
    }else {
      this.onHotkey = onHotkey!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      var hotkeys = hotkeySelector(settings.hotkeys);

      var nextChild = builder(context, hotkeys);
      for (var shortcut in _shortcuts(hotkeys)) {
        // TODO: this causes repaints
        nextChild = shortcut(nextChild);
      }

      return Provider.value(value: HotkeyMapping(hotkeys), child: nextChild);
    });
  }

  List<Widget Function(Widget)> _shortcuts(Map<String, String> hotkeys) {
    return hotkeys
        .map((key, value) => MapEntry(
            key,
            (Widget child) => KeyBoardShortcuts(
                  child: child,
                  keysToPress: convertKeyMap(value),
                  onKeysPressed: () => onHotkey(key),
                  globalShortcuts: global,
                )))
        .values
        .toList();
  }
}

class HotkeyMapping {
  final Map<String, String> mappings;

  HotkeyMapping(this.mappings);
}

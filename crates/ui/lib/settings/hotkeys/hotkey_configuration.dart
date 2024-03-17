import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/settings/hotkeys/keymap.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:provider/provider.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

const modifierKeys = {
  "ctrl": HotKeyModifier.control,
  "cmd": HotKeyModifier.meta,
  "alt": HotKeyModifier.alt,
  "shift": HotKeyModifier.shift,
};

class HotkeyConfiguration extends StatefulWidget {
  final Widget child;
  final Map<String, String> Function(Hotkeys) hotkeySelector;
  final Map<String, Function()> hotkeyMap;

  HotkeyConfiguration(
      {required this.hotkeySelector,
      required this.child,
      required this.hotkeyMap,
      bool? global = false});

  @override
  State<HotkeyConfiguration> createState() => _HotkeyConfigurationState();
}

class _HotkeyConfigurationState extends State<HotkeyConfiguration> {
  List<HotKey> hotkeys = [];

  @override
  void didUpdateWidget(HotkeyConfiguration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hotkeySelector != widget.hotkeySelector ||
        oldWidget.hotkeyMap != widget.hotkeyMap) {
      _updateHotkeys();
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SettingsBloc>();
    var hotkeys = HotkeyMapping(widget.hotkeySelector(bloc.state.hotkeys));

    return Provider.value(value: hotkeys, child: widget.child);
  }

  @override
  void initState() {
    super.initState();
    _updateHotkeys();
  }

  void _updateHotkeys() {
    Settings settings = context.read<Settings>();
    if (this.hotkeys.isNotEmpty) {
      this.hotkeys.forEach((hotkey) {
        hotKeyManager.unregister(hotkey);
      });
    }
    var hotkeyMappings = widget.hotkeySelector(settings.hotkeys);

    var hotkeys = hotkeyMappings.map((hotkeyId, hotkeyKeys) {
      var hotkeyParts = hotkeyKeys
          .split("+")
          .map((e) => e.trim())
          .toSet();
      var modifiers = hotkeyParts
          .map((element) => modifierKeys[element])
          .where((element) => element != null)
          .map((e) => e!)
          .toList();
      var key = hotkeyParts
          .where((element) => !modifierKeys.containsKey(element))
          .map((e) => keyMappings[e])
          .where((element) => element != null)
          .map((e) => e!)
          .first;
      var hotkey = HotKey(key: key, modifiers: modifiers, scope: HotKeyScope.inapp);

      return MapEntry(hotkeyId, hotkey);
    });

    hotkeys.forEach((hotkeyId, hotkey) {
      hotKeyManager.register(hotkey, keyDownHandler: (_) {
        var callback = widget.hotkeyMap[hotkeyId];
        if (callback != null) {
          callback();
        }
      });
    });

    this.hotkeys = hotkeys.values.toList();
  }

  @override
  void dispose() {
    super.dispose();

  }
}

class HotkeyMapping {
  final Map<String, String> mappings;

  HotkeyMapping(this.mappings);
}

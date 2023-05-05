import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/settings/hotkeys/hotkey_manager.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:provider/provider.dart';

import 'keymap.dart';

class HotkeyProvider extends StatefulWidget {
  final Widget child;

  const HotkeyProvider({required this.child, Key? key}) : super(key: key);

  @override
  State<HotkeyProvider> createState() => _HotkeyProviderState();
}

class _HotkeyProviderState extends State<HotkeyProvider> {
  HotkeyManager _manager = HotkeyManager();

  @override
  Widget build(BuildContext context) {
    return ListenableProvider.value(
        value: _manager, child: HotkeyShortcutsMapping(child: widget.child));
  }
}

class HotkeyShortcutsMapping extends StatefulWidget {
  final Widget child;

  const HotkeyShortcutsMapping({required this.child, Key? key}) : super(key: key);

  @override
  State<HotkeyShortcutsMapping> createState() => _HotkeyShortcutsMappingState();
}

class _HotkeyShortcutsMappingState extends State<HotkeyShortcutsMapping> {
  @override
  Widget build(BuildContext context) {
    var manager = context.watch<HotkeyManager>();

    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      return CallbackShortcuts(
          bindings: _bindings(manager, settings),
          child: FocusScope(child: widget.child, autofocus: true, skipTraversal: true, debugLabel: "HotkeyMappings"));
    });
  }

  Map<ShortcutActivator, VoidCallback> _bindings(HotkeyManager manager, Settings settings) {
    return manager.value.map((hotkeys) {
      var hotkeyKeybindings = hotkeys.selector(settings.hotkeys);

      return hotkeys.actions.map((key, value) => MapEntry(hotkeyKeybindings[key], value));
    }).fold(Map(), (result, hotkeys) {
      hotkeys.removeWhere((key, value) => key == null);
      var mappedHotkeys =
          hotkeys.map((key, value) => MapEntry(LogicalKeySet.fromSet(convertKeyMap(key!)), value));

      result.addAll(mappedHotkeys);

      return result;
    });
  }
}

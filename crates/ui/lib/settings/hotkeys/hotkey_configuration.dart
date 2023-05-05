import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/settings/hotkeys/hotkey_manager.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:provider/provider.dart';

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
  HotkeyWidgetKey? _hotkeyWidgetKey;

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
    this._hotkeyWidgetKey = this._hotkeyManager.acquireKey();
    _updateHotkeys();
  }

  void _updateHotkeys() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this._hotkeyManager.setHotkeys(_hotkeyWidgetKey!, widget.hotkeySelector, widget.hotkeyMap);
    });
  }

  HotkeyManager get _hotkeyManager {
    return context.read();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _hotkeyWidgetKey?.dispose();
    });
  }
}

class HotkeyMapping {
  final Map<String, String> mappings;

  HotkeyMapping(this.mappings);
}

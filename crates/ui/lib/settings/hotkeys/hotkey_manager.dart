import 'package:flutter/foundation.dart';
import 'package:mizer/api/contracts/settings.dart';

typedef HotkeySelector = Map<String, String> Function(Hotkeys);

class HotkeyWidgetValue {
  HotkeySelector selector;

  Map<String, Function()> actions;

  HotkeyWidgetValue(this.selector, this.actions);
}

class HotkeyManager extends ValueListenable<List<HotkeyWidgetValue>> {
  List<VoidCallback> _listener = [];
  Map<HotkeyWidgetKey, HotkeyWidgetValue> _hotkeys = Map();

  HotkeyWidgetKey acquireKey() {
    var widgetKey = new HotkeyWidgetKey();
    widgetKey.dispose = () => this.dropHotkeys(widgetKey);

    return widgetKey;
  }

  void dropHotkeys(HotkeyWidgetKey? hotkeyWidgetKey) {
    _hotkeys.remove(hotkeyWidgetKey);

    this._callListener();
  }

  setHotkeys(HotkeyWidgetKey key, HotkeySelector hotkeyKeybindings,
      Map<String, Function()> hotkeyActions) {
    this._hotkeys[key] = HotkeyWidgetValue(hotkeyKeybindings, hotkeyActions);

    this._callListener();
  }

  @override
  void addListener(VoidCallback listener) {
    this._listener.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    this._listener.remove(listener);
  }

  @override
  List<HotkeyWidgetValue> get value => _hotkeys.values.toList();

  _callListener() {
    for (var listener in this._listener) {
      listener();
    }
  }
}

class HotkeyWidgetKey {
  late Function() dispose;
}

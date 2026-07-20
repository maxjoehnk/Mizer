import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_manager.dart';
import 'package:provider/provider.dart';

class LayoutHotkeys extends StatefulWidget {
  final Layout layout;
  final Widget? child;

  const LayoutHotkeys({super.key, required this.layout, this.child});

  @override
  State<LayoutHotkeys> createState() => _LayoutHotkeysState();
}

class _LayoutHotkeysState extends State<LayoutHotkeys> {
  HotkeyWidgetKey? _hotkeyWidgetKey;

  @override
  void didUpdateWidget(LayoutHotkeys oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.layout != widget.layout) {
      _updateHotkeys();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child);
  }

  @override
  void initState() {
    super.initState();
    _hotkeyWidgetKey = _hotkeyManager.acquireKey();
    _updateHotkeys();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _hotkeyWidgetKey?.dispose();
    });
  }

  void _updateHotkeys() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this._hotkeyManager.setHotkeys(_hotkeyWidgetKey!, (_) => _hotkeys, _hotkeyActions);
    });
  }

  HotkeyManager get _hotkeyManager {
    return context.read();
  }

  Map<String, String> get _hotkeys {
    var controlsWithHotkeys = widget.layout.controls.where((c) => c.hasHotkey());

    return Map.fromIterable(controlsWithHotkeys, key: (c) => c.id, value: (c) => c.hotkey);
  }

  Map<String, Function()> get _hotkeyActions {
    NodesApi apiClient = context.read();
    var controlsWithHotkeys = widget.layout.controls.where((c) => c.hasHotkey());

    return Map.fromIterable(controlsWithHotkeys, key: (c) => c.id, value: (c) {
      return () async {
        await apiClient.writeControlValue(path: c.node.path, port: "Input", value: 1);
        await Future.delayed(Duration(milliseconds: 100));
        await apiClient.writeControlValue(path: c.node.path, port: "Input", value: 0);
      };
    });
  }
}

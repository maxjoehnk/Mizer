import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/dialog/action_dialog.dart';
import 'package:mizer/widgets/field/field.dart';

class HotkeySelectorDialog extends StatefulWidget {
  const HotkeySelectorDialog({super.key});

  @override
  State<HotkeySelectorDialog> createState() => _HotkeySelectorDialogState();
}

class _HotkeySelectorDialogState extends State<HotkeySelectorDialog> {
  final FocusNode focusNode = FocusNode(debugLabel: "HotkeySelectorDialog");
  String currentHotkey = "";

  String key = "";
  bool shift = false;
  bool ctrl = false;
  bool alt = false;
  bool cmd = false;

  @override
  Widget build(BuildContext context) {
    return ActionDialog(
        title: "Define Keyboard Shortcut".i18n,
        actions: [
          PopupAction("Cancel".i18n, () => Navigator.of(context).pop()),
          PopupAction("Confirm".i18n, () => Navigator.of(context).pop(currentHotkey.toLowerCase())),
        ],
        content: KeyboardListener(
            focusNode: focusNode,
            onKeyEvent: (event) {
              if (event is KeyDownEvent) {
                if (event.logicalKey.isShift) {
                  shift = true;
                } else if (event.logicalKey.isCtrl) {
                  ctrl = true;
                } else if (event.logicalKey.isCmd) {
                  cmd = true;
                } else if (event.logicalKey.isAlt) {
                  alt = true;
                } else {
                  key = event.logicalKey.keyLabel;
                }
                updateHotkey();
              }
              if (event is KeyUpEvent) {
                if (event.logicalKey.isShift) {
                  shift = false;
                } else if (event.logicalKey.isCtrl) {
                  ctrl = false;
                } else if (event.logicalKey.isCmd) {
                  cmd = false;
                } else if (event.logicalKey.isAlt) {
                  alt = false;
                } else {
                  key = "";
                }
              }
            },
            autofocus: true,
            child: Field(big: true, label: "Combination".i18n, child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(currentHotkey, textAlign: TextAlign.end),
            ))));
  }
  
  void updateHotkey() {
    String hotkey = "";
    if (key.isEmpty) {
      return;
    }
    if (shift) {
      hotkey += "Shift+";
    }
    if (ctrl) {
      hotkey += "Ctrl+";
    }
    if (alt) {
      hotkey += "Alt+";
    }
    if (cmd) {
      hotkey += "Cmd+";
    }
    hotkey += key;
    setState(() {
      currentHotkey = hotkey;
    });
  }
}

extension LogicalKeyModifiers on LogicalKeyboardKey {
  bool get isShift => this == LogicalKeyboardKey.shiftLeft || this == LogicalKeyboardKey.shiftRight || this == LogicalKeyboardKey.shift;

  bool get isCtrl => this == LogicalKeyboardKey.controlLeft || this == LogicalKeyboardKey.controlRight || this == LogicalKeyboardKey.control;

  bool get isAlt => this == LogicalKeyboardKey.altLeft || this == LogicalKeyboardKey.altRight || this == LogicalKeyboardKey.alt;

  bool get isCmd => this == LogicalKeyboardKey.metaLeft || this == LogicalKeyboardKey.metaRight || this == LogicalKeyboardKey.meta;
}

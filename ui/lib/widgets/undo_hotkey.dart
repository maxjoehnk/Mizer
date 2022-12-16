import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:provider/provider.dart';

class UndoHotkeyConfiguration extends StatelessWidget {
  final Widget child;

  const UndoHotkeyConfiguration({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HotkeyConfiguration(
        hotkeySelector: (hotkeys) => hotkeys.global,
        hotkeyMap: {
          "undo": () => _undo(context),
          "redo": () => _redo(context),
        },
        child: child);
  }

  _undo(BuildContext context) {
    context.read<SessionApi>().undo();
    context.refreshAllStates();
  }

  _redo(BuildContext context) {
    context.read<SessionApi>().redo();
    context.refreshAllStates();
  }
}

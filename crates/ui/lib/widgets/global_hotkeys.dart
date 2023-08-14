import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/project_files.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:provider/provider.dart';

class GlobalHotkeyConfiguration extends StatelessWidget {
  final Widget child;

  const GlobalHotkeyConfiguration({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HotkeyConfiguration(
        hotkeySelector: (hotkeys) => hotkeys.global,
        hotkeyMap: {
          "undo": () => _undo(context),
          "redo": () => _redo(context),
          "save": () => ProjectFiles.saveProject(context),
          // FIXME: when these are pressed, the other hotkeys don't work any longer
          // "save_as": () => ProjectFiles.saveProjectAs(context),
          // "open": () => ProjectFiles.openProject(context),
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

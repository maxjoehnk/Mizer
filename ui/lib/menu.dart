import 'dart:io' as io;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide MenuItem;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/plugin/app.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/windows/preferences_window.dart';
import 'package:mizer/windows/smart_window.dart';
import 'package:nativeshell/nativeshell.dart' show Window;

import 'api/contracts/session.dart';

class ApplicationMenu extends StatelessWidget {
  final Widget child;

  ApplicationMenu({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, Session>(
      builder: (context, state) => MenuBar(
          child: child,
          menu: Menu(items: [
            SubMenu(title: "File".i18n, children: [
              MenuItem(
                  label: "New Project".i18n,
                  action: () => _newProject(context),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN)),
              MenuItem(
                  label: "Open Project".i18n,
                  action: () => _openProject(context, context.read()),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO)),
              SubMenu(
                title: "Open Recent".i18n,
                children: state.projectHistory
                    .map((history) => MenuItem(
                        label: history.split(io.Platform.pathSeparator).last,
                        action: () => _openProjectFromHistory(context, context.read(), history)))
                    .toList(),
              ),
              MenuItem(
                  disabled: state.filePath.isEmpty,
                  label: 'Save Project'.i18n,
                  action: () => context.read<SessionApi>().saveProject(),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS)),
              MenuItem(
                  label: 'Save Project as'.i18n,
                  action: () => _saveProjectAs(context, context.read()),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
                      LogicalKeyboardKey.keyS)),
              MenuDivider(),
              MenuItem(
                  label: 'Preferences'.i18n,
                  action: () {
                    return Window.create(PreferencesWindow.toInitData())
                        .then((window) => window.showModal());
                  }),
              MenuItem(
                  label: "Exit".i18n,
                  action: () => context.read<ApplicationPluginApi>().exit(),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ))
            ]),
            SubMenu(title: 'Edit'.i18n, children: [
              MenuItem(
                  label: 'Undo'.i18n,
                  action: () async {
                    await context.read<SessionApi>().undo();
                    _refreshViews(context);
                  },
                  // shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ)
              ),
              MenuItem(
                  label: 'Redo'.i18n,
                  action: () async {
                    await context.read<SessionApi>().redo();
                    _refreshViews(context);
                  },
                  // shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
                  //     LogicalKeyboardKey.keyZ)
              )
            ]),
            SubMenu(title: 'Window'.i18n, children: [
              MenuItem(
                  label: 'New Window'.i18n,
                  action: () => Window.create({}).then((window) => window.show())),
              MenuItem(
                label: 'Smart Window'.i18n,
                  action: () => Window.create(SmartWindow.toInitData()).then((window) => window.show())
              ),
              MenuDivider(),
              MenuItem(
                label: 'Close Window',
                action: () => Window.of(context).close()
              )
            ])
          ])),
    );
  }

  Future<void> _newProject(BuildContext context) async {
    await context.read<SessionApi>().newProject();
    _refreshViews(context);
  }

  Future<void> _openProject(BuildContext context, SessionApi api) async {
    final typeGroup = XTypeGroup(label: 'Projects'.i18n, extensions: ['yml']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) {
      return;
    }
    await api.loadProject(file.path);
    _refreshViews(context);
  }

  Future<void> _openProjectFromHistory(
      BuildContext context, SessionApi api, String filePath) async {
    await api.loadProject(filePath);
    _refreshViews(context);
  }

  Future<void> _saveProjectAs(BuildContext context, SessionApi api) async {
    final typeGroup = XTypeGroup(label: 'Projects'.i18n, extensions: ['yml']);
    final path = await getSavePath(acceptedTypeGroups: [typeGroup]);
    if (path == null) {
      return;
    }
    await api.saveProjectAs(path);
  }

  void _refreshViews(BuildContext context) {
    context.refreshAllStates();
  }
}

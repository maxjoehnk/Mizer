import 'dart:io' as io;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/plugin/app.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/session.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/layouts_bloc.dart';
import 'package:mizer/state/media_bloc.dart';
import 'package:mizer/state/nodes_bloc.dart';
import 'package:mizer/state/plans_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:mizer/windows/preferences_window.dart';
import 'package:nativeshell/nativeshell.dart' show Window;

import 'actions/actions.dart';
import 'actions/menu.dart';
import 'api/contracts/session.dart';
import 'navigation.dart';

class ApplicationMenu extends StatelessWidget {
  final Widget child;

  ApplicationMenu({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, Session>(
      builder: (context, state) => MenuBar(
          child: child,
          menu: Menu(items: [
            SubMenu(title: "File", children: [
              MenuItem(
                  label: "New Project",
                  action: () => _newProject(context),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN)),
              MenuItem(
                  label: "Open Project",
                  action: () => _openProject(context, context.read()),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO)),
              SubMenu(
                title: "Open Recent",
                children: state.projectHistory
                    .map((history) => MenuItem(
                        label: history.split(io.Platform.pathSeparator).last,
                        action: () => _openProjectFromHistory(context, context.read(), history)))
                    .toList(),
              ),
              MenuItem(
                  disabled: state.filePath.isEmpty,
                  label: 'Save Project',
                  action: () => context.read<SessionApi>().saveProject(),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS)),
              MenuItem(
                  label: 'Save Project as',
                  action: () => _saveProjectAs(context, context.read()),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
                      LogicalKeyboardKey.keyS)),
              MenuDivider(),
              MenuItem(
                  label: 'Preferences',
                  action: () {
                    return Window.create(PreferencesWindow.toInitData())
                      .then((window) => window.showModal());
                  }),
              MenuItem(
                  label: "Exit",
                  action: () => context.read<ApplicationPluginApi>().exit(),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ))
            ]),
            SubMenu(
                title: 'View',
                children: routes
                    .mapEnumerated((route, index) =>
                        MenuActionItem(label: route.label, action: OpenViewIntent(index)))
                    .toList()),
            if (!context.platform.isStandalone)
              SubMenu(title: 'Window', children: [
                MenuItem(
                    label: 'New Window',
                    action: () => Window.create({}).then((window) => window.show()))
              ])
          ])),
    );
  }

  Future<void> _newProject(BuildContext context) async {
    await context.read<SessionApi>().newProject();
    _refreshViews(context);
  }

  Future<void> _openProject(BuildContext context, SessionApi api) async {
    final typeGroup = XTypeGroup(label: 'Projects', extensions: ['yml']);
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
    final typeGroup = XTypeGroup(label: 'Projects', extensions: ['yml']);
    final path = await getSavePath(acceptedTypeGroups: [typeGroup]);
    if (path == null) {
      return;
    }
    await api.saveProjectAs(path);
  }

  void _refreshViews(BuildContext context) {
    context.read<FixturesBloc>().add(FetchFixtures());
    context.read<LayoutsBloc>().add(FetchLayouts());
    context.read<MediaBloc>().add(MediaEvent.Fetch);
    context.read<NodesBloc>().add(FetchNodes());
    context.read<SequencerBloc>().add(FetchSequences());
    context.read<PresetsBloc>().add(FetchPresets());
    context.read<PlansBloc>().add(FetchPlans());
  }
}

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
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/state/session_bloc.dart';
import 'package:nativeshell/nativeshell.dart' show Window;

import 'actions/actions.dart';
import 'actions/menu.dart';
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
            SubMenu(title: "File", children: [
              MenuItem(
                  label: "New Project",
                  action: () => _newProject(context),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN)),
              MenuItem(
                  label: "Open Project",
                  action: () => _openProject(context, context.read()),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO)),
              MenuItem(
                  disabled: state.filePath.isEmpty,
                  label: 'Save Project',
                  action: () => context.read<SessionApi>().saveProject(),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS)),
              MenuItem(
                  label: 'Save Project as',
                  action: () => _saveProjectAs(context, context.read()),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift, LogicalKeyboardKey.keyS)),
              MenuDivider(),
              MenuItem(label: 'Preferences'),
              MenuItem(
                  label: "Exit",
                  action: () => context.read<ApplicationPluginApi>().exit(),
                  shortcut: LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ))
            ]),
            SubMenu(title: 'View', children: [
              MenuActionItem(label: "Layout", action: OpenViewIntent(View.Layout)),
              MenuActionItem(label: "2D Plan", action: OpenViewIntent(View.Plan)),
              MenuActionItem(label: "PreViz", action: OpenViewIntent(View.PreViz)),
              MenuActionItem(label: "Nodes", action: OpenViewIntent(View.Nodes)),
              MenuActionItem(label: "Sequences", action: OpenViewIntent(View.Sequences)),
              MenuActionItem(label: "Fixtures", action: OpenViewIntent(View.Programmer)),
              MenuActionItem(label: "Media", action: OpenViewIntent(View.Media)),
              MenuActionItem(label: "Connections", action: OpenViewIntent(View.Connections)),
              MenuActionItem(label: "Session", action: OpenViewIntent(View.Session)),
            ]),
            if (!context.platform.isStandalone) SubMenu(title: 'Window', children: [
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
  }
}

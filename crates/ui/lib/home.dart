import 'package:flutter/material.dart' hide View, NavigationBar, Route;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/plugin/app.dart';
import 'package:mizer/dialogs/power_dialog.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/menu.dart';
import 'package:mizer/panes/console/console_pane.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/views/connections/connections_view.dart';
import 'package:mizer/views/effects/effects_view.dart';
import 'package:mizer/views/fixtures/fixtures_view.dart';
import 'package:mizer/views/history/history_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/media/media_view.dart';
import 'package:mizer/views/midi_profiles/midi_profiles_view.dart';
import 'package:mizer/views/nodes/nodes_view.dart';
import 'package:mizer/views/patch/fixture_patch.dart';
import 'package:mizer/views/plan/plan_view.dart';
import 'package:mizer/views/preferences/preferences.dart';
import 'package:mizer/views/presets/presets_view.dart';
import 'package:mizer/views/sequencer/sequencer_view.dart';
import 'package:mizer/views/session/session_view.dart';
import 'package:mizer/views/surfaces/surfaces_view.dart';
import 'package:mizer/views/timecode/timecode_view.dart';
import 'package:mizer/widgets/navigation_bar/navigation_bar.dart';
import 'package:mizer/widgets/status_bar.dart';
import 'package:mizer/widgets/transport/transport_controls.dart';
import 'package:provider/provider.dart';

import 'actions/actions.dart';
import 'panes/programmer/programmer_view.dart';
import 'panes/selection/selection_pane.dart';
import 'views/dmx_output/dmx_output.dart';

const double SHEET_SIZE = 150;
const double SHEET_PADDING = 0;
const double TAB_STRIP_HEIGHT = 32;
const double BOTTOM_PANE_CONTAINER_HEIGHT = SHEET_SIZE + TAB_STRIP_HEIGHT + SHEET_PADDING;

List<Route> routes = [
  Route(() => LayoutViewWrapper(), Icons.view_quilt_outlined, 'Layout'.i18n, View.Layout),
  Route(() => PlanView(), MdiIcons.viewComfy, '2D Plan'.i18n, View.Plan),
  Route(() => FetchNodesView(), Icons.account_tree_outlined, 'Nodes'.i18n, View.Nodes),
  Route(() => SequencerView(), MdiIcons.animationPlayOutline, 'Sequencer'.i18n, View.Sequencer),
  Route(() => FixturesView(), MdiIcons.tuneVertical, 'Fixtures'.i18n, View.Programmer),
  Route(() => PresetsView(), MdiIcons.paletteSwatch, 'Presets'.i18n, View.Presets),
  Route(() => EffectsView(), MdiIcons.vectorCircle, 'Effects'.i18n, View.Effects),
  Route(() => MediaView(), Icons.perm_media_outlined, 'Media'.i18n, View.Media),
  Route(() => SurfacesView(), Icons.tv, 'Surfaces'.i18n, View.Surfaces),
  Route(() => FixturePatchView(), MdiIcons.spotlight, 'Patch'.i18n, View.FixturePatch),
  Route(() => DmxOutputView(), Icons.bar_chart, 'DMX Output'.i18n, View.DmxOutput),
  Route(() => ConnectionsView(), Icons.device_hub, 'Connections'.i18n, View.Connections),
  Route(() => TimecodeView(), MdiIcons.chartTimeline, 'Timecode'.i18n, View.Timecode),
  Route(() => HistoryView(), Icons.history, 'History'.i18n, View.History),
  Route(() => SessionView(), Icons.mediation, 'Session'.i18n, View.Session),
  Route(() => PreferencesView(), Icons.settings, 'Preferences'.i18n, View.Preferences),
  Route(() => MidiProfilesView(), MdiIcons.midi, 'MIDI Profiles'.i18n, View.MidiProfiles),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Widget? _currentWidget;
  bool _showProgrammer = true;
  bool _showSelection = false;
  bool _showConsole = false;

  _HomeState() {
    _updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.global,
      hotkeyMap: _getShortcuts(routes),
      child: ApplicationMenu(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  HomeNavigation(
                    selectedIndex: _selectedIndex,
                    onSelect: this._selectView,
                    routes: routes,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: SafeArea(
                          child: Container(
                              child: RepaintBoundary(child: _currentWidget),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration()),
                        ),
                      ),
                      if (_showConsole)
                        SizedBox(height: BOTTOM_PANE_CONTAINER_HEIGHT, child: ConsolePane()),
                      if (_showSelection)
                        SizedBox(height: BOTTOM_PANE_CONTAINER_HEIGHT, child: SelectionPane()),
                      if (_showProgrammer)
                        SizedBox(
                            height: BOTTOM_PANE_CONTAINER_HEIGHT, child: ProgrammerView()),
                      RepaintBoundary(
                          child: TransportControls(
                              showProgrammer: _showProgrammer,
                              toggleProgrammer: () => _toggleProgrammerPane(),
                              showSelection: _showSelection,
                              toggleSelection: () => _toggleSelectionPane(),
                              showConsole: _showConsole,
                              toggleConsole: () => _toggleConsolePane(),
                          )),
                    ],
                  ))
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            RepaintBoundary(
              child: StatusBar(),
            )
          ],
        ),
      ),
    ));
  }

  void _toggleSelectionPane() {
    return setState(() {
      _showSelection = !_showSelection;
      _showProgrammer = false;
      _showConsole = false;
    });
  }

  void _toggleProgrammerPane() {
    return setState(() {
      _showProgrammer = !_showProgrammer;
      _showSelection = false;
      _showConsole = false;
    });
  }

  void _toggleConsolePane() {
    return setState(() {
      _showConsole = !_showConsole;
      _showSelection = false;
      _showProgrammer = false;
    });
  }

  void _updateWidget() {
    _currentWidget = routes[_selectedIndex].view();
  }

  void _selectView(int index) {
    setState(() {
      _selectedIndex = index;
      _updateWidget();
    });
  }

  Map<String, Function()> _getShortcuts(List<Route> routes) {
    Map<String, Function()> shortcuts = {
      'programmer_pane': () => _toggleProgrammerPane(),
      'selection_pane': () => _toggleSelectionPane(),
      'console_pane': () => _toggleConsolePane(),
    };
    for (var entry in routes.asMap().entries) {
      shortcuts[entry.value.viewKey.toHotkeyString()] = () => _selectView(entry.key);
    }
    return shortcuts;
  }
}

class HomeNavigation extends StatelessWidget {
  final List<Route> routes;
  final int selectedIndex;
  final Function(int) onSelect;

  const HomeNavigation({super.key, required this.routes, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    HotkeyMapping mapping = context.read();
    ApplicationPluginApi applicationApi = context.read();

    return NavigationBar(children: [
      NavigationBarItem(
          label: "Power",
          icon: MdiIcons.power,
          onSelect: () => showDialog(
              context: context, builder: (context) => PowerDialog(applicationApi: applicationApi))),
      ...this.routes.mapEnumerated((route, i) => NavigationRouteItem(
          route, this.selectedIndex == i, () => this.onSelect(i), mapping.mappings))
    ]);
  }
}


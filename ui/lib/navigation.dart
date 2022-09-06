import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/menu.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/views/connections/connections_view.dart';
import 'package:mizer/views/effects/effects_view.dart';
import 'package:mizer/views/fixtures/fixtures_view.dart';
import 'package:mizer/views/history/history_view.dart';
import 'package:mizer/views/plan/plan_view.dart';
import 'package:mizer/views/presets/presets_view.dart';
import 'package:mizer/views/programmer/programmer_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/media/media_view.dart';
import 'package:mizer/views/nodes/nodes_view.dart';
import 'package:mizer/views/patch/fixture_patch.dart';
import 'package:mizer/widgets/transport/transport_controls.dart';
import 'package:mizer/views/sequencer/sequencer_view.dart';
import 'package:mizer/views/session/session_view.dart';
import 'package:mizer/extensions/string_extensions.dart';

import 'actions/actions.dart';

const double SHEET_SIZE = 320;
const double SHEET_PADDING = 16;
const double TAB_STRIP_HEIGHT = 32;
const double SHEET_CONTAINER_HEIGHT = SHEET_SIZE + TAB_STRIP_HEIGHT + SHEET_PADDING;

List<Route> routes = [
  Route(() => LayoutView(), Icons.view_quilt_outlined, 'Layout'.i18n, View.Layout),
  Route(() => PlanView(), Icons.view_comfortable, '2D Plan'.i18n, View.Plan),
  Route(() => Container(), MdiIcons.video3D, 'PreViz'.i18n, View.PreViz),
  Route(() => FetchNodesView(), Icons.account_tree_outlined, 'Nodes'.i18n, View.Nodes),
  Route(() => SequencerView(), MdiIcons.animationPlayOutline, 'Sequencer'.i18n, View.Sequencer),
  Route(() => FixturesView(), MdiIcons.tuneVertical, 'Fixtures'.i18n, View.Programmer),
  Route(() => PresetsView(), MdiIcons.paletteSwatch, 'Presets'.i18n, View.Presets),
  Route(() => EffectsView(), MdiIcons.vectorCircle, 'Effects'.i18n, View.Effects),
  Route(
      () => MediaView(), Icons.perm_media_outlined, 'Media'.i18n, View.Media),
  Route(() => Container(), Icons.tv, 'Surfaces'.i18n, View.Surfaces),
  Route(() => ConnectionsView(), Icons.device_hub, 'Connections'.i18n, View.Connections),
  Route(() => FixturePatchView(), MdiIcons.spotlight, 'Patch'.i18n, View.FixturePatch),
  Route(() => SessionView(), Icons.mediation, 'Session'.i18n, View.Session),
  Route(() => HistoryView(), Icons.history, 'History'.i18n, View.History),
];

Map<String, OpenViewIntent> shortcuts = getShortcuts(routes);

Map<String, OpenViewIntent> getShortcuts(List<Route> routes) {
  Map<String, OpenViewIntent> shortcuts = {};
  for (var entry in routes.asMap().entries) {
    shortcuts[entry.value.viewKey.toHotkeyString()] = OpenViewIntent(entry.key);
  }
  return shortcuts;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Widget? _currentWidget;
  bool _showProgrammer = false;

  _HomeState() {
    _updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HotkeyProvider(
            hotkeySelector: (hotkeys) => hotkeys.global,
            global: true,
            onHotkey: (hotkey) {
              var intent = shortcuts[hotkey]!;
              this._selectView(intent.viewIndex);
            },
            builder: (context, hotkeys) => ApplicationMenu(
                child: Actions(
                  actions: <Type, CallbackAction>{
                    OpenViewIntent: CallbackAction<OpenViewIntent>(
                      onInvoke: (intent) => this._selectView(intent.viewIndex),
                    ),
                  },
                  child: Focus(
                    autofocus: true,
                    child: Row(
                      children: [
                        NavigationBar(
                          selectedIndex: _selectedIndex,
                          onSelect: this._selectView,
                          routes: routes,
                          hotkeys: hotkeys,
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
                                if (_showProgrammer) SizedBox(height: SHEET_CONTAINER_HEIGHT, child: ProgrammerView()),
                                RepaintBoundary(child: TransportControls(showProgrammer: _showProgrammer, toggleProgrammer: () => setState(() => _showProgrammer = !_showProgrammer)))
                              ],
                            ))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
            ),
        ));
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
}

class Route {
  final WidgetFunction view;
  final IconData icon;
  final String label;
  final View viewKey;

  Route(this.view, this.icon, this.label, this.viewKey);
}

typedef WidgetFunction = Widget Function();

class NavigationBar extends StatelessWidget {
  final List<Route> routes;
  final Map<String, String> hotkeys;
  final int selectedIndex;
  final Function(int) onSelect;

  NavigationBar({required this.routes, required this.selectedIndex, required this.onSelect, required this.hotkeys});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade800,
        width: 64,
        child: ListView(
            children: this
                .routes
                .mapEnumerated((route, i) =>
                    NavigationItem(route, this.selectedIndex == i, () => this.onSelect(i), this.hotkeys))
                .toList()));
  }
}

extension MapWithIndex<T> on List<T> {
  List<R> mapEnumerated<R>(R Function(T, int i) callback) {
    return this.asMap().map((key, value) => MapEntry(key, callback(value, key))).values.toList();
  }
}

class NavigationItem extends StatefulWidget {
  final Route route;
  final bool selected;
  final void Function() onSelect;
  final Map<String, String> hotkeys;

  NavigationItem(this.route, this.selected, this.onSelect, this.hotkeys);

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var color = this.widget.selected ? theme.accentColor : theme.hintColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onExit: (e) => setState(() => hovering = false),
      onHover: (e) => setState(() => hovering = true),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: this.widget.onSelect,
        child: Container(
          height: 64,
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      this.widget.route.icon,
                      color: color,
                      size: 24,
                    ),
                    Text(this.widget.route.label,
                        style: textTheme.subtitle2!.copyWith(color: color, fontSize: 10)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              if (hotkeyLabel != null) Align(alignment: Alignment.topRight, child: Text(hotkeyLabel!.toCapitalCase(), style: textTheme.caption!.copyWith(fontSize: 9))),
            ],
          ),
        ),
      ),
    );
  }

  String? get hotkeyLabel {
    return widget.hotkeys[widget.route.viewKey.toHotkeyString()];
  }

  Color? get backgroundColor {
    if (widget.selected) {
      return Colors.black26;
    }
    if (hovering) {
      return Colors.black12;
    }
    return null;
  }
}

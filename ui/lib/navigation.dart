import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/menu.dart';
import 'package:mizer/views/connections/connections_view.dart';
import 'package:mizer/views/fixtures/fixtures_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/media/media_view.dart';
import 'package:mizer/views/nodes/nodes_view.dart';
import 'package:mizer/views/session/session_view.dart';

import 'actions/actions.dart';

List<Route> routes = [
  Route(() => LayoutView(), Icons.view_quilt_outlined, 'Layout', LogicalKeyboardKey.digit1, View.Layout),
  Route(() => Container(), Icons.view_comfortable, '2D Plan', LogicalKeyboardKey.digit2, View.Plan2D),
  Route(() => Container(), MdiIcons.video3D, 'PreViz', LogicalKeyboardKey.digit3, View.PreViz),
  Route(() => FetchNodesView(), Icons.account_tree_outlined, 'Nodes', LogicalKeyboardKey.digit4, View.Nodes),
  Route(() => Container(), MdiIcons.animationPlayOutline, 'Sequences', LogicalKeyboardKey.digit5, View.Sequences),
  Route(() => FixturesView(), MdiIcons.spotlight, 'Fixtures', LogicalKeyboardKey.digit6, View.Fixtures),
  Route(() => MediaView(), Icons.perm_media_outlined, 'Media', LogicalKeyboardKey.digit7, View.Media),
  Route(() => ConnectionsView(), Icons.device_hub, 'Devices', LogicalKeyboardKey.digit8, View.Devices),
  Route(() => SessionView(), Icons.mediation, 'Session', LogicalKeyboardKey.digit9, View.Session),
];

Map<LogicalKeySet, Intent> shortcuts = getShortcuts(routes);

Map<LogicalKeySet, Intent> getShortcuts(List<Route> routes) {
  Map<LogicalKeySet, Intent> shortcuts = {};
  for (var route in routes) {
    shortcuts[LogicalKeySet(
      LogicalKeyboardKey.alt,
      route.key,
    )] = OpenViewIntent(route.viewKey);
  }
  return shortcuts;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Widget _currentWidget;

  _HomeState() {
    _updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Shortcuts(
      shortcuts: shortcuts,
      child: ApplicationMenu(
        child: Actions(
          actions: <Type, CallbackAction>{
            OpenViewIntent: CallbackAction<OpenViewIntent>(
              onInvoke: (intent) => this._selectView(intent.view.index),
            )
          },
          child: Focus(
            autofocus: true,
            child: Row(
              children: [
                NavigationBar(
                  selectedIndex: _selectedIndex,
                  onSelect: this._selectView,
                  routes: routes,
                ),
                Expanded(child: Container(child: _currentWidget, clipBehavior: Clip.antiAlias, decoration: BoxDecoration()))
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
  final LogicalKeyboardKey key;
  final View viewKey;

  Route(this.view, this.icon, this.label, this.key, this.viewKey);
}

typedef WidgetFunction = Widget Function();

class NavigationBar extends StatelessWidget {
  final List<Route> routes;
  final int selectedIndex;
  final Function(int) onSelect;

  NavigationBar({this.routes, this.selectedIndex, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade800,
        width: 64,
        child: ListView(
            children: this
                .routes
                .mapEnumerated((route, i) =>
                    NavigationItem(route, this.selectedIndex == i, () => this.onSelect(i)))
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
  final Function onSelect;

  NavigationItem(this.route, this.selected, this.onSelect);

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
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            children: [
              Icon(
                this.widget.route.icon,
                color: color,
                size: 24,
              ),
              Text(this.widget.route.label, style: textTheme.subtitle2.copyWith(color: color, fontSize: 10)),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  Color get backgroundColor {
    if (widget.selected) {
      return Colors.black26;
    }
    if (hovering) {
      return Colors.black12;
    }
    return null;
  }
}

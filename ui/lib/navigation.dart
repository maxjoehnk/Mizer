import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/views/connections/connections_view.dart';
import 'package:mizer/views/fixtures/fixtures_view.dart';
import 'package:mizer/views/layout/layout_view.dart';
import 'package:mizer/views/media/media_view.dart';
import 'package:mizer/views/nodes/nodes_view.dart';
import 'package:mizer/views/session/session_view.dart';
import 'package:mizer/views/settings/settings_view.dart';

List<Route> routes = [
  Route(() => LayoutView(), Icons.view_quilt_outlined, "Layout"),
  Route(() => FetchNodesView(), Icons.account_tree_outlined, "Nodes"),
  Route(() => FixturesView(), MdiIcons.spotlight, "Fixtures"),
  Route(() => MediaView(), Icons.perm_media_outlined, "Media"),
  Route(() => ConnectionsView(), Icons.device_hub, "Devices"),
  Route(() => SessionView(), Icons.mediation, "Session"),
  Route(() => SettingsView(), Icons.settings, "Settings"),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class OpenViewIntent extends Intent {
  final int view;

  const OpenViewIntent(this.view);
}

Map<LogicalKeySet, Intent> shortcuts = {
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit1,
  ): const OpenViewIntent(0),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit2,
  ): const OpenViewIntent(1),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit3,
  ): const OpenViewIntent(2),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit4,
  ): const OpenViewIntent(3),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit5,
  ): const OpenViewIntent(4),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit6,
  ): const OpenViewIntent(5),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit7,
  ): const OpenViewIntent(6),
  LogicalKeySet(
    LogicalKeyboardKey.alt,
    LogicalKeyboardKey.digit8,
  ): const OpenViewIntent(7),
};

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
          child: Actions(
            actions: <Type, CallbackAction>{
              OpenViewIntent: CallbackAction<OpenViewIntent>(
                onInvoke: (intent) => this._selectView(intent.view),
              )
            },
            child: Focus(autofocus: true, child: Row(
              children: [
                NavigationBar(
                  selectedIndex: _selectedIndex,
                  onSelect: this._selectView,
                  routes: routes,
                ),
                Expanded(child: _currentWidget)
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),),
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

  Route(this.view, this.icon, this.label);
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
        child: Column(
            children: this
                .routes
                .mapEnumerated((route, i) =>
                NavigationItem(
                    route, this.selectedIndex == i, () => this.onSelect(i)))
                .toList()));
  }
}

extension MapWithIndex<T> on List<T> {
  List<R> mapEnumerated<R>(R Function(T, int i) callback) {
    return this
        .asMap()
        .map((key, value) => MapEntry(key, callback(value, key)))
        .values
        .toList();
  }
}

class NavigationItem extends StatelessWidget {
  final Route route;
  final bool selected;
  final Function onSelect;

  NavigationItem(this.route, this.selected, this.onSelect);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var color = this.selected ? theme.primaryColor : theme.hintColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: this.onSelect,
      child: Container(
        width: 64,
        height: 64,
        color: this.selected ? Colors.black12 : null,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Icon(
              this.route.icon,
              color: color,
              size: 16,
            ),
            Text(this.route.label,
                style: textTheme.subtitle2.copyWith(color: color)),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

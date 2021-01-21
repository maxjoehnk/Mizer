import 'package:flutter/material.dart';
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
  Route(() => ConnectionsView(), Icons.device_hub, "Connections"),
  Route(() => SessionView(), Icons.mediation, "Session"),
  Route(() => SettingsView(), Icons.settings, "Settings"),
];

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
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                  _updateWidget();
                });
              },
              labelType: NavigationRailLabelType.selected,
              destinations: routes.map((route) => route.toRail()).toList(),
            ),
            Expanded(child: _currentWidget)
          ],
        ));
  }

  void _updateWidget() {
    _currentWidget = routes[_selectedIndex].view();
  }
}

class Route {
  final WidgetFunction view;
  final IconData icon;
  final String label;

  Route(this.view, this.icon, this.label);

  NavigationRailDestination toRail() {
    return NavigationRailDestination(
        icon: Icon(this.icon), label: Text(this.label));
  }
}

typedef WidgetFunction = Widget Function();

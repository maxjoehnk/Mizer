import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ui/blocs/fixtures_bloc.dart';
import 'package:ui/blocs/nodes_bloc.dart';
import 'package:ui/views/connections/connections_view.dart';
import 'package:ui/views/fixtures/fixtures_view.dart';
import 'package:ui/views/layout/layout_view.dart';
import 'package:ui/views/media/media_view.dart';
import 'package:ui/views/nodes/nodes_view.dart';
import 'package:ui/views/session/session_view.dart';
import 'package:ui/views/settings/settings_view.dart';

import 'blocs/session_bloc.dart';

void main() async {
  final channel = ClientChannel(
    '192.168.1.13',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  runApp(MyApp(channel));
}

class MyApp extends StatelessWidget {
  final ClientChannel channel;

  MyApp(this.channel);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => NodesBloc(channel)),
          BlocProvider(create: (BuildContext context) => SessionBloc(channel)),
          BlocProvider(create: (BuildContext context) => FixturesBloc(channel)),
        ],
        child: MaterialApp(
          title: 'Mizer',
          theme: ThemeData.dark(),
          home: Home(),
          themeMode: ThemeMode.dark,
        ));
  }
}

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

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

class Home extends StatefulWidget {
  final List<Widget> widgets = [
    LayoutView(),
    FetchNodesView(),
    FixturesView(),
    MediaView(),
    ConnectionsView(),
    SessionView(),
    SettingsView(),
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

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
            });
          },
          labelType: NavigationRailLabelType.all,
          destinations: [
            NavigationRailDestination(
                icon: const Icon(Icons.view_quilt_outlined),
                label: Text("Layout")),
            NavigationRailDestination(
                icon: const Icon(Icons.account_tree_outlined),
                label: Text("Nodes")),
            NavigationRailDestination(
              icon: const Icon(MdiIcons.spotlight),
              label: Text("Fixtures"),
            ),
            NavigationRailDestination(
                icon: const Icon(Icons.perm_media_outlined),
                label: Text("Media")),
            NavigationRailDestination(
                icon: const Icon(Icons.device_hub), label: Text("Connections")),
            NavigationRailDestination(
                icon: const Icon(Icons.mediation), label: Text("Session")),
            NavigationRailDestination(
                icon: const Icon(Icons.settings), label: Text("Settings")),
          ],
        ),
        Expanded(child: widget.widgets[_selectedIndex])
      ],
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/api/contracts/transport.dart';

import 'connections.dart';
import 'fixtures.dart';
import 'layouts.dart';
import 'media.dart';
import 'nodes.dart';
import 'programmer.dart';
import 'sequencer.dart';
import 'session.dart';
import 'settings.dart';
import 'transport.dart';

class DemoApiProvider extends StatelessWidget {
  final Widget child;

  DemoApiProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<FixturesApi>(create: (context) => FixturesDemoApi()),
        RepositoryProvider<LayoutsApi>(create: (context) => LayoutsDemoApi()),
        RepositoryProvider<MediaApi>(create: (context) => MediaDemoApi()),
        RepositoryProvider<NodesApi>(create: (context) => NodesDemoApi()),
        RepositoryProvider<TransportApi>(create: (context) => TransportDemoApi()),
        RepositoryProvider<SessionApi>(create: (context) => SessionDemoApi()),
        RepositoryProvider<ConnectionsApi>(create: (context) => ConnectionsDemoApi()),
        RepositoryProvider<SequencerApi>(create: (_) => SequencerDemoApi()),
        RepositoryProvider<ProgrammerApi>(create: (_) => ProgrammerDemoApi()),
        RepositoryProvider<SettingsApi>(create: (_) => SettingsDemoApi()),
      ]
    );
  }

}

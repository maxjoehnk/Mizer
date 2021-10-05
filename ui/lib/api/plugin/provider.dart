import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/plugin/programmer.dart';

import 'connections.dart';
import 'fixtures.dart';
import 'layouts.dart';
import 'media.dart';
import 'nodes.dart';
import 'sequencer.dart';
import 'session.dart';
import 'transport.dart';

class PluginApiProvider extends StatelessWidget {
  final Widget child;

  PluginApiProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<ConnectionsApi>(create: (context) => ConnectionsPluginApi()),
        RepositoryProvider<FixturesApi>(create: (context) => FixturesPluginApi()),
        RepositoryProvider<LayoutsApi>(create: (context) => LayoutsPluginApi()),
        RepositoryProvider<MediaApi>(create: (context) => MediaPluginApi()),
        RepositoryProvider<NodesApi>(create: (context) => NodesPluginApi()),
        RepositoryProvider<SessionApi>(create: (context) => SessionPluginApi()),
        RepositoryProvider<TransportApi>(create: (context) => TransportPluginApi()),
        RepositoryProvider<SequencerApi>(create: (_) => SequencerPluginApi()),
        RepositoryProvider<ProgrammerApi>(create: (_) => ProgrammerPluginApi()),
      ],
    );
  }
}

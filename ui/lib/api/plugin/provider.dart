import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/mappings.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/api/contracts/transport.dart';
import 'package:mizer/api/contracts/effects.dart';

import 'app.dart';
import 'connections.dart';
import 'fixtures.dart';
import 'layouts.dart';
import 'mappings.dart';
import 'media.dart';
import 'nodes.dart';
import 'programmer.dart';
import 'sequencer.dart';
import 'session.dart';
import 'transport.dart';
import 'effects.dart';
import 'plans.dart';
import 'ffi/api.dart';
import 'ffi/bindings.dart';

class PluginApiProvider extends StatelessWidget {
  final Widget child;
  late final FFIBindings bindings;

  PluginApiProvider({required this.child}) {
    this.bindings = openBindings();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<ConnectionsApi>(create: (context) => ConnectionsPluginApi()),
        RepositoryProvider<FixturesApi>(create: (context) => FixturesPluginApi()),
        RepositoryProvider<LayoutsApi>(create: (context) => LayoutsPluginApi(bindings)),
        RepositoryProvider<MediaApi>(create: (context) => MediaPluginApi()),
        RepositoryProvider<NodesApi>(create: (context) => NodesPluginApi(bindings)),
        RepositoryProvider<SessionApi>(create: (context) => SessionPluginApi()),
        RepositoryProvider<TransportApi>(create: (context) => TransportPluginApi(bindings)),
        RepositoryProvider<SequencerApi>(create: (_) => SequencerPluginApi(bindings)),
        RepositoryProvider<ProgrammerApi>(create: (_) => ProgrammerPluginApi(bindings)),
        RepositoryProvider<SettingsApi>(create: (_) => ApplicationPluginApi()),
        RepositoryProvider<ApplicationPluginApi>(create: (_) => ApplicationPluginApi()),
        RepositoryProvider<EffectsApi>(create: (_) => EffectsPluginApi()),
        RepositoryProvider<PlansApi>(create: (_) => PlansPluginApi(bindings)),
        RepositoryProvider<MappingsApi>(create: (_) => MappingsPluginApi()),
      ],
    );
  }
}

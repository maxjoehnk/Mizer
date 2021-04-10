import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/session.dart';

import 'fixtures.dart';
import 'layouts.dart';
import 'media.dart';
import 'nodes.dart';
import 'session.dart';

class PluginApiProvider extends StatelessWidget {
  final Widget child;

  PluginApiProvider({@required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<FixturesApi>(create: (context) => FixturesPluginApi()),
        RepositoryProvider<LayoutsApi>(create: (context) => LayoutsPluginApi()),
        RepositoryProvider<MediaApi>(create: (context) => MediaPluginApi()),
        RepositoryProvider<NodesApi>(create: (context) => NodesPluginApi()),
        RepositoryProvider<SessionApi>(create: (context) => SessionPluginApi()),
      ],
    );
  }
}

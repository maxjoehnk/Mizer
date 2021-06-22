import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/contracts/media.dart';
import 'package:mizer/api/contracts/nodes.dart';
import 'package:mizer/api/contracts/session.dart';
import 'package:mizer/api/contracts/transport.dart';

import '../preview_handler.dart';
import 'fixtures.dart';
import 'layouts.dart';
import 'media.dart';
import 'nodes.dart';
import 'session.dart';
import 'transport.dart';

class DemoApiProvider extends StatelessWidget {
  final Widget child;

  DemoApiProvider({@required this.child});

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
        RepositoryProvider(create: (context) => PreviewHandler(context.read())),
      ]
    );
  }

}

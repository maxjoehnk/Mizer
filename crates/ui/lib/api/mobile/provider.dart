import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';

import 'package:mizer/api/demo/fixtures.dart';
import 'package:mizer/api/demo/programmer.dart';
import 'package:mizer/api/demo/sequencer.dart';
import 'package:mizer/api/mobile/fixtures.dart';
import 'programmer.dart';
import 'package:mizer/api/mobile/sequencer.dart';

class MobileApiProvider extends StatelessWidget {
  final Widget child;
  final String host;
  final int port;

  const MobileApiProvider({required this.child, required this.host, required this.port});

  @override
  Widget build(BuildContext context) {
    if (host == "demo") {
      return MultiRepositoryProvider(child: child, providers: [
        RepositoryProvider<FixturesApi>(create: (context) => FixturesDemoApi()),
        RepositoryProvider<ProgrammerApi>(create: (context) => ProgrammerDemoApi()),
        RepositoryProvider<SequencerRemoteApi>(create: (context) => SequencerDemoApi()),
      ]);
    }

    var clientChannel = ClientChannel(host,
        port: port, options: ChannelOptions(credentials: ChannelCredentials.insecure()));
    return MultiRepositoryProvider(child: child, providers: [
      RepositoryProvider<FixturesApi>(create: (context) => FixturesMobileApi(clientChannel)),
      RepositoryProvider<ProgrammerApi>(create: (context) => ProgrammerMobileApi(clientChannel)),
      RepositoryProvider<SequencerRemoteApi>(create: (context) => SequencerMobileApi(clientChannel)),
    ]);
  }
}

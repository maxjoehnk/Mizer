import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/programmer.dart';

import 'fixtures.dart';
import 'programmer.dart';

class MobileApiProvider extends StatelessWidget {
  final Widget child;
  final InternetAddress host;
  final int port;

  const MobileApiProvider({required this.child, required this.host, required this.port});

  @override
  Widget build(BuildContext context) {
    var clientChannel = ClientChannel(host,
        port: port, options: ChannelOptions(credentials: ChannelCredentials.insecure()));
    return MultiRepositoryProvider(child: child, providers: [
      RepositoryProvider<FixturesApi>(create: (context) => FixturesMobileApi(clientChannel)),
      RepositoryProvider<ProgrammerApi>(create: (context) => ProgrammerMobileApi(clientChannel)),
    ]);
  }
}

// @dart=2.11
import 'package:flutter/material.dart';
import 'package:mizer/app.dart';
import 'package:mizer/navigation.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/platform/standalone/platform.dart';
import 'package:mizer/session/session_discovery.dart';
import 'package:mizer/session/session_selector.dart';
import 'package:mizer/state/provider.dart';
import 'package:provider/provider.dart';

import 'api/grpc/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final discovery = SessionDiscovery();
  await discovery.start();

  runApp(MizerRemoteApp(discovery));
}

class MizerRemoteApp extends StatelessWidget {
  final SessionDiscovery discovery;

  MizerRemoteApp(this.discovery);

  @override
  Widget build(BuildContext context) {
    return MizerApp(
        child: Provider<Platform>(
          create: (_) => StandalonePlatform(),
          child: SessionProvider(discovery,
              builder: (channel) => GrpcApiProvider(channel, child: StateProvider(child: Home()))),
        ));
  }
}

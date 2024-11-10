import 'package:flutter/material.dart';
import 'package:mizer/api/mobile/provider.dart';
import 'package:mizer/app.dart';
import 'package:mizer/i18n.dart';

import 'fixture_list.dart';
import 'session_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MizerI18n.loadTranslations();
  runApp(MizerMobileUi());
}

class MizerMobileUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MizerApp(
      child: SessionSelector(
          builder: (context, connection) => MobileApiProvider(
              child: FixtureList(onDisconnect: connection.disconnect),
              host: connection.session.host.host,
              port: connection.session.host.port)),
    );
  }
}

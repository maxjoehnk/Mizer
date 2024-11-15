import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/mobile/provider.dart';
import 'package:mizer/app.dart';
import 'package:mizer/i18n.dart';

import 'fixture_list.dart';
import 'navigation.dart';
import 'sequence_list.dart';
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
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Mizer'),
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Disconnect'),
                          onTap: () => connection.disconnect(),
                        )
                      ],
                    )
                  ],
                ),
                body: Navigation(tabs: [
                  MobileTab(child: FixtureList(), title: "Patch".i18n, icon: MdiIcons.spotlight),
                  MobileTab(child: SequenceList(), title: "Sequences".i18n, icon: MdiIcons.animationPlayOutline),
                ]),
              ),
              host: connection.session.host.host,
              port: connection.session.host.port)),
    );
  }
}

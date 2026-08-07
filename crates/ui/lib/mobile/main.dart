import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:mizer/api/mobile/provider.dart';
import 'package:mizer/app.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/mobile/fixture_list.dart';
import 'package:mizer/mobile/navigation.dart';
import 'package:mizer/mobile/sequence_list.dart';
import 'package:mizer/mobile/session_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MizerI18n.loadTranslations();
  runApp(MizerMobileUi());
}

class MizerMobileUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: const Locale('en'),
      supportedLocales: ['en'.asLocale],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: MizerApp(
        child: SessionSelector(
            builder: (context, connection) => MobileApiProvider(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Grey800,
                    shadowColor: Colors.transparent,
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
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:mizer/app.dart';
import 'package:nativeshell/nativeshell.dart';

import 'package:mizer/i18n.dart';
import 'package:mizer/windows/main_window.dart';
import 'package:mizer/windows/midi_monitor_window.dart';
import 'package:mizer/windows/osc_monitor_window.dart';
import 'package:mizer/windows/smart_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MizerI18n.loadTranslations();
  runApp(MizerIntegratedUi());
}

class MizerIntegratedUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: const Locale('en'),
      supportedLocales: ['de'.asLocale, 'en'.asLocale],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: MizerApp(child: WindowWidget(onCreateState: (initData) {
        WindowState? state;

        state ??= MidiMonitorWindow.fromInitData(initData);
        state ??= OscMonitorWindow.fromInitData(initData);
        state ??= SmartWindow.fromInitData(initData);
        state ??= MainWindowState();

        return state;
      })),
    );
  }
}

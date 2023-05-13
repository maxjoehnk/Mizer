import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';

class MizerApp extends StatelessWidget {
  final Widget child;

  MizerApp({required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = getTheme();
    return MaterialApp(
      title: 'Mizer',
      darkTheme: theme,
      home: I18n(initialLocale: Locale('en'), child: child),
      themeMode: ThemeMode.dark,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en'), const Locale('de')],
    );
  }

  static ThemeData getTheme() {
    final theme = ThemeData.dark();
    return theme.copyWith(
        colorScheme: theme.colorScheme
            .copyWith(primary: Colors.blueGrey, secondary: Colors.deepOrangeAccent),
        primaryColor: Colors.blueGrey);
  }
}

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';

class MizerApp extends StatelessWidget {
  final Widget child;

  MizerApp({required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = getTheme();
    return MaterialApp(
      title: 'Mizer',
      darkTheme: theme,
      home: child,
      themeMode: ThemeMode.dark,
      locale: I18n.locale,
      supportedLocales: I18n.supportedLocales,
      localizationsDelegates: I18n.localizationsDelegates,
    );
  }

  static ThemeData getTheme() {
    final theme = ThemeData.dark(useMaterial3: false);
    return theme.copyWith(
        colorScheme: theme.colorScheme
            .copyWith(primary: Colors.blueGrey, secondary: Colors.deepOrangeAccent),
        primaryColor: Colors.blueGrey);
  }
}

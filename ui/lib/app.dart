import 'package:flutter/material.dart';

class MizerApp extends StatelessWidget {
  final Widget child;

  MizerApp({required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = _getTheme();
    return MaterialApp(
      title: 'Mizer',
      darkTheme: theme,
      home: child,
      themeMode: ThemeMode.dark,
    );
  }

  ThemeData _getTheme() {
    final theme = ThemeData.dark();
    return theme
        .copyWith(
        colorScheme: theme.colorScheme.copyWith(
            primary: Colors.blueGrey, secondary: Colors.deepOrangeAccent),
        primaryColor: Colors.blueGrey, accentColor: Colors.deepOrangeAccent
    );
  }
}

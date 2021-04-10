import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MizerApp extends StatelessWidget {
  final Widget child;

  MizerApp({@required this.child});

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
    return ThemeData.dark()
        .copyWith(primaryColor: Colors.blueGrey, accentColor: Colors.deepOrangeAccent);
  }
}

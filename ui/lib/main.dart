import 'package:flutter/material.dart';
import 'package:mizer/navigation.dart';
import 'package:mizer/session/session_discovery.dart';
import 'package:mizer/session/session_selector.dart';
import 'package:mizer/state/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final discovery = SessionDiscovery();
  await discovery.start();

  runApp(MyApp(discovery));
}

class MyApp extends StatelessWidget {
  final SessionDiscovery discovery;

  MyApp(this.discovery);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = _getTheme();
    return MaterialApp(
      title: 'Mizer',
      darkTheme: theme,
      home: SessionProvider(discovery, builder: (channel) => StateProvider(channel, child: Home())),
      themeMode: ThemeMode.dark,
    );
  }

  ThemeData _getTheme() {
    return ThemeData.dark()
        .copyWith(primaryColor: Colors.blueGrey, accentColor: Colors.deepOrangeAccent);
  }
}

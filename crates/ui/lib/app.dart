import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/theme.dart';

class MizerApp extends StatelessWidget {
  final Widget child;

  MizerApp({required this.child});

  @override
  Widget build(BuildContext context) {
    print("Build MizerApp");
    return BlocBuilder<SettingsBloc, Settings>(
      buildWhen: (lhs, rhs) => lhs.ui.theme != rhs.ui.theme,
      builder: (context, state) {
        return MaterialApp(
          title: 'Mizer',
          theme: lightTheme(),
          darkTheme: darkTheme(),
          home: child,
          themeMode: state.ui.theme == "light" ? ThemeMode.light : ThemeMode.dark,
          locale: I18n.locale,
          supportedLocales: I18n.supportedLocales,
          localizationsDelegates: I18n.localizationsDelegates,
        );
      },
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/api/plugin/provider.dart';
import 'package:mizer/platform/integrated/platform.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/provider.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:provider/provider.dart';

class BaseWindowState extends StatelessWidget {
  final Widget child;

  const BaseWindowState({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Platform>(
        create: (_) => IntegratedPlatform(),
        child: PluginApiProvider(child: StateProvider(child: HotkeyProvider(child: child))));
  }
}

class LanguageSwitcher extends StatelessWidget {
  final Widget child;

  const LanguageSwitcher({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(
      builder: (context, settings) {
        var i18n = I18n.of(context);
        if (settings.hasGeneral() && i18n.locale.languageCode != settings.general.language) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            i18n.locale = Locale(settings.general.language);
          });
        }
        return child;
      },
    );
  }
}

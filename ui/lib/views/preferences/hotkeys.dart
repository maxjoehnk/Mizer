import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/settings_bloc.dart';

import 'preferences.dart';

class HotkeySettings extends StatelessWidget {
  const HotkeySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PreferencesCategory.hotkeys("Global".i18n, settings.hotkeys.global),
            PreferencesCategory.hotkeys("Layouts".i18n, settings.hotkeys.layouts),
            PreferencesCategory.hotkeys("Plan".i18n, settings.hotkeys.plan),
            PreferencesCategory.hotkeys("Programmer".i18n, settings.hotkeys.programmer),
            PreferencesCategory.hotkeys("Nodes".i18n, settings.hotkeys.nodes),
            PreferencesCategory.hotkeys("Patch".i18n, settings.hotkeys.patch),
            PreferencesCategory.hotkeys("Sequencer".i18n, settings.hotkeys.sequencer),
          ],
        ),
      );
    });
  }
}

class HotkeySetting extends StatelessWidget {
  final String label;
  final String combination;

  const HotkeySetting({required this.label, required this.combination, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsRow(label, [Text(combination)]);
  }
}

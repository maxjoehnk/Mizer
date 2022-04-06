import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
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
            PreferencesCategory.hotkeys("Global", settings.hotkeys.global),
            PreferencesCategory.hotkeys("Layouts", settings.hotkeys.layouts),
            PreferencesCategory.hotkeys("Plan", settings.hotkeys.plan),
            PreferencesCategory.hotkeys("Programmer", settings.hotkeys.programmer),
            PreferencesCategory.hotkeys("Nodes", settings.hotkeys.nodes),
            PreferencesCategory.hotkeys("Patch", settings.hotkeys.patch),
            PreferencesCategory.hotkeys("Sequencer", settings.hotkeys.sequencer),
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

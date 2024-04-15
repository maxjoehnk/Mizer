import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/widgets/hotkey_formatter.dart';
import 'package:mizer/widgets/hoverable.dart';

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
            _category(context, settings, "Global".i18n, (hotkeys) => hotkeys.global),
            _category(context, settings, "Layouts".i18n, (hotkeys) => hotkeys.layouts),
            _category(context, settings, "Plan".i18n, (hotkeys) => hotkeys.plan),
            _category(context, settings, "Nodes".i18n, (hotkeys) => hotkeys.nodes),
            _category(context, settings, "Sequencer".i18n, (hotkeys) => hotkeys.sequencer),
            _category(context, settings, "Effects".i18n, (hotkeys) => hotkeys.effects),
            _category(context, settings, "Media".i18n, (hotkeys) => hotkeys.media),
            _category(context, settings, "Patch".i18n, (hotkeys) => hotkeys.patch),
            _category(context, settings, "Programmer".i18n, (hotkeys) => hotkeys.programmer),
          ],
        ),
      );
    });
  }

  Widget _category(BuildContext context, Settings settings, String label, Map<String, String> Function(Hotkeys) selector) {
    return PreferencesCategory.hotkeys(label, selector(settings.hotkeys), update(context, selector));
  }

  Function(String, String?) update(BuildContext context, Map<String, String> Function(Hotkeys) getHotkeys) {
    return (key, combination) {
      SettingsBloc bloc = context.read();
      bloc.add(UpdateSettings((settings) {
        getHotkeys(settings.hotkeys)[key] = combination ?? "";

        return settings;
      }));
    };
  }
}

class HotkeySetting extends StatelessWidget {
  final String label;
  final String combination;
  final Function(String?) update;

  const HotkeySetting({required this.label, required this.combination, Key? key, required this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsRow(label, [
      Text(formatHotkey(combination)),
      SizedBox(width: 8),
      Hoverable(
        builder: (hover) => Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          decoration: BoxDecoration(
            color: hover ? Colors.grey.shade700 : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: Icon(Icons.clear, size: 12)),
        ),
        onTap: () {
          this.update(null);
        },
      )
    ]);
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';

import 'file_paths.dart';
import 'general.dart';
import 'hotkeys.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Panel(
            label: "Preferences".i18n,
            padding: false,
            tabs: [
              Tab(label: "General".i18n, child: GeneralSettings()),
              Tab(label: "File Paths".i18n, child: PathSettings()),
              Tab(label: "Hotkeys".i18n, child: HotkeySettings()),
            ],
            actions: [
              PanelActionModel(
                  label: "Save".i18n,
                  onClick: () => context.read<SettingsBloc>().add(SaveSettings())),
            ],
          ),
        ),
      ],
    );
  }
}

class PreferencesCategory extends StatelessWidget {
  final String label;
  final bool subcategory;
  final List<Widget> children;

  const PreferencesCategory(
      {required this.label, required this.children, this.subcategory = false, Key? key})
      : super(key: key);

  factory PreferencesCategory.hotkeys(
      String label, Map<String, String> hotkeys, Function(String, String?) update) {
    return PreferencesCategory(
        label: label,
        children: hotkeys.entries
            .sortedBy((e) => e.key)
            .map((e) => HotkeySetting(
                  label: _title(e.key),
                  combination: e.value,
                  update: (combination) => update(e.key, combination),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(label, style: subcategory ? textTheme.titleSmall : textTheme.titleLarge),
          ),
          ...children
        ]);
  }
}

class SettingsRow extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const SettingsRow(this.label, this.children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(label),
          )),
      ...children
    ]);
  }
}

String _title(String key) {
  return key.split("_").map((e) => "${e[0].toUpperCase()}${e.substring(1)}").join(" ");
}

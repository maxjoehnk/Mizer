import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/widgets/controls/button.dart';
import 'package:mizer/widgets/tabs.dart';
import 'package:nativeshell/nativeshell.dart';

import 'file_paths.dart';
import 'hotkeys.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Tabs(children: [
            Tab(label: "File Paths", child: PathSettings()),
            Tab(label: "Hotkeys", child: HotkeySettings()),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            MizerButton(child: Text("Cancel"), onClick: () => Window.of(context).close()),
            MizerButton(child: Text("Save"), onClick: () => context.read<SettingsBloc>().add(SaveSettings(Window.of(context)))),
          ]),
        )
      ],
    );
  }
}

class PreferencesCategory extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const PreferencesCategory({required this.label, required this.children, Key? key})
      : super(key: key);

  factory PreferencesCategory.hotkeys(String label, Map<String, String> hotkeys) {
    return PreferencesCategory(
        label: label,
        children: hotkeys.entries
            .map((e) => HotkeySetting(label: _title(e.key), combination: e.value))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(label, style: textTheme.titleLarge), ...children]);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/boolean_field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/enum_field.dart';
import 'package:mizer/widgets/controls/select.dart';

import 'preferences.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(spacing: 4, mainAxisSize: MainAxisSize.min, children: [
          LanguageSetting(
              label: "Language".i18n,
              locale: settings.general.language,
              update: (language) {
                SettingsBloc bloc = context.read();
                bloc.add(UpdateSettings((settings) {
                  settings.general.language = language;

                  return settings;
                }));
              }),
          BooleanField(
              label: "Auto load last project".i18n,
              labelWidth: 200,
              value: settings.general.autoLoadLastProject,
              onUpdate: (value) {
                SettingsBloc bloc = context.read();
                bloc.add(UpdateSettings((settings) {
                  settings.general.autoLoadLastProject = value;

                  return settings;
                }));
              })
        ]),
      );
    });
  }
}

class LanguageSetting extends StatelessWidget {
  final String label;
  final String locale;
  final Function(String) update;

  const LanguageSetting({required this.label, required this.locale, required this.update, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EnumField(
      label: label,
      labelWidth: 200,
      initialValue: locale,
      items: [
        SelectOption(value: "de", label: "Deutsch"),
        SelectOption(value: "en", label: "English"),
      ],
      onUpdate: update,
    );
  }
}

class BoolSetting extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) update;

  const BoolSetting({required this.label, required this.value, required this.update, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsRow(label, [
      Expanded(
        flex: 1,
        child: MizerSelect<bool>(
            value: value,
            options: [
              SelectOption(value: true, label: "Yes"),
              SelectOption(value: false, label: "No"),
            ],
            onChanged: update),
      )
    ]);
  }
}

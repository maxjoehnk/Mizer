import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/settings.pb.dart'
    show SettingsCategory, Settings, Setting, SettingsGroup, Setting_Value, UpdateSetting, PathListSetting;
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/boolean_field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/enum_field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/path_field.dart';
import 'package:mizer/views/preferences/file_paths.dart';
import 'package:mizer/views/preferences/hotkeys.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(
      builder: (context, settings) {
        return Column(
          children: [
            Expanded(
              child: Panel(
                label: "Preferences".i18n,
                padding: false,
                tabs: settings.categories
                    .map((c) => Tab(
                          label: c.title,
                          child: PreferencesCategory(category: c),
                        ))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PreferencesCategory extends StatelessWidget {
  final SettingsCategory category;

  const PreferencesCategory({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        child: Column(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: category.groups.map((g) => PreferencesGroup(group: g)).toList()),
      ),
    );
  }
}

class PreferencesGroup extends StatelessWidget {
  final SettingsGroup group;

  const PreferencesGroup({required this.group, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (group.hasTitle())
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(group.title, style: textTheme.titleLarge),
            ),
          ...group.settings.map((s) => Preference(
                s,
                onUpdate: (UpdateSetting update) {
                  context.read<SettingsBloc>().add(ApplyUpdate(update));
                },
              )),
        ]);
  }
}

class Preference extends StatelessWidget {
  final Setting setting;
  final Function(UpdateSetting) onUpdate;

  const Preference(this.setting, {super.key, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    if (setting.whichValue() == Setting_Value.boolean) {
      return BooleanField(
          label: setting.title,
          labelWidth: 200,
          value: setting.boolean.value,
          resetToDefault: !setting.defaultValue,
          onResetToDefault: () => onUpdate(UpdateSetting(key: setting.key)),
          onUpdate: (value) => onUpdate(UpdateSetting(key: setting.key, boolean: value)));
    }
    if (setting.whichValue() == Setting_Value.select) {
      return EnumField(
        label: setting.title,
        labelWidth: 200,
        initialValue: setting.select.selected,
        items: setting.select.values
            .map((option) => SelectOption(value: option.value, label: option.title))
            .toList(),
        resetToDefault: !setting.defaultValue,
        onResetToDefault: () => onUpdate(UpdateSetting(key: setting.key)),
        onUpdate: (value) => onUpdate(UpdateSetting(key: setting.key, select: value)),
      );
    }
    if (setting.whichValue() == Setting_Value.hotkey) {
      return HotkeySetting(
          label: setting.title,
          combination: setting.hotkey.combination,
          resetToDefault: !setting.defaultValue,
          onResetToDefault: () => onUpdate(UpdateSetting(key: setting.key)),
          update: (hotkey) => onUpdate(UpdateSetting(key: setting.key, hotkey: hotkey)));
    }
    if (setting.whichValue() == Setting_Value.path) {
      return PathField(
          label: setting.title,
          labelWidth: 200,
          value: setting.path.path,
          resetToDefault: !setting.defaultValue,
          onResetToDefault: () => onUpdate(UpdateSetting(key: setting.key)),
          onUpdate: (value) => onUpdate(UpdateSetting(key: setting.key, path: value)));
    }
    if (setting.whichValue() == Setting_Value.pathList) {
      return PathsSetting(
          label: setting.title,
          paths: setting.pathList.paths,
          resetToDefault: !setting.defaultValue,
          onResetToDefault: () => onUpdate(UpdateSetting(key: setting.key)),
          onUpdate: (paths) =>
              onUpdate(UpdateSetting(key: setting.key, pathList: PathListSetting(paths: paths))));
    }

    return Container();
  }
}

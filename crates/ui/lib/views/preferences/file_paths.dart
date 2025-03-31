import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/widgets/field/field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/path_field.dart';
import 'package:mizer/widgets/controls/button.dart';

import 'preferences.dart';

class PathSettings extends StatelessWidget {
  const PathSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(shrinkWrap: true, children: [
          PreferencesCategory(label: "Media", children: [
            PathField(label: "Storage".i18n, value: settings.paths.mediaStorage, onUpdate: (path) {
                  SettingsBloc bloc = context.read();
                  bloc.add(UpdateSettings((settings) {
                    settings.paths.mediaStorage = path;

                    return settings;
                  }));
                }),
          ]),
          PreferencesCategory(label: "Midi Device Profiles".i18n, children: [
            PathsSetting(
                paths: settings.paths.midiDeviceProfiles,
                update: (paths) {
                  SettingsBloc bloc = context.read();
                  bloc.add(UpdateSettings((settings) {
                    settings.paths.midiDeviceProfiles.clear();
                    settings.paths.midiDeviceProfiles.addAll(paths);

                    return settings;
                  }));
                }),
          ]),
          PreferencesCategory(label: "Fixture Libraries".i18n, children: [
            PreferencesCategory(label: "Open Fixture Library".i18n, subcategory: true, children: [
              PathsSetting(
                  paths: settings.paths.openFixtureLibrary,
                  update: (paths) {
                    SettingsBloc bloc = context.read();
                    bloc.add(UpdateSettings((settings) {
                      settings.paths.openFixtureLibrary.clear();
                      settings.paths.openFixtureLibrary.addAll(paths);

                      return settings;
                    }));
                  }),
            ]),
            PreferencesCategory(label: "QLC+".i18n, subcategory: true, children: [
              PathsSetting(
                  paths: settings.paths.qlcplus,
                  update: (paths) {
                    SettingsBloc bloc = context.read();
                    bloc.add(UpdateSettings((settings) {
                      settings.paths.qlcplus.clear();
                      settings.paths.qlcplus.addAll(paths);

                      return settings;
                    }));
                  }),
            ]),
            PreferencesCategory(label: "GDTF".i18n, subcategory: true, children: [
              PathsSetting(
                  paths: settings.paths.gdtf,
                  update: (paths) {
                    SettingsBloc bloc = context.read();
                    bloc.add(UpdateSettings((settings) {
                      settings.paths.gdtf.clear();
                      settings.paths.gdtf.addAll(paths);

                      return settings;
                    }));
                  }),
            ]),
            PreferencesCategory(label: "Mizer".i18n, subcategory: true, children: [
              PathsSetting(
                  paths: settings.paths.mizer,
                  update: (paths) {
                    SettingsBloc bloc = context.read();
                    bloc.add(UpdateSettings((settings) {
                      settings.paths.mizer.clear();
                      settings.paths.mizer.addAll(paths);

                      return settings;
                    }));
                  }),
            ]),
          ]),
        ]),
      );
    });
  }
}

class PathsSetting extends StatelessWidget {
  final List<String> paths;
  final Function(List<String>) update;

  const PathsSetting({required this.paths, required this.update, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 4, mainAxisSize: MainAxisSize.min, children: [
      ...paths.mapEnumerated((path, i) {
        return PathField(
            value: path,
            onUpdate: (p) {
              update(paths.mapEnumerated((p, j) => i == j ? p : p).toList());
            },
            actions: [
              FieldAction(
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                  onTap: () {
                    update(paths.whereIndexed((_, j) => i != j).toList());
                  })
            ]);
      }),
      MizerButton(
          child: Text("Add Path"),
          onClick: () async {
            final path = await getDirectoryPath();
            if (path == null) {
              return;
            }
            update([...paths, path]);
          })
    ]);
  }
}

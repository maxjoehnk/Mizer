import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/navigation.dart';
import 'package:mizer/state/settings_bloc.dart';

import 'preferences.dart';
import 'settings_button.dart';

class PathSettings extends StatelessWidget {
  const PathSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        PathSettingRow(
            label: "Media Storage".i18n,
            value: settings.paths.mediaStorage,
            update: (path) {
              SettingsBloc bloc = context.read();
              bloc.add(UpdateSettings((settings) {
                settings.paths.mediaStorage = path;

                return settings;
              }));
            }),
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
          PathSettingRow(
              label: "Open Fixture Library".i18n,
              value: settings.paths.openFixtureLibrary,
              update: (path) {
                SettingsBloc bloc = context.read();
                bloc.add(UpdateSettings((settings) {
                  settings.paths.openFixtureLibrary = path;

                  return settings;
                }));
              }),
          PathSettingRow(
              label: "QLC+".i18n,
              value: settings.paths.qlcplus,
              update: (path) {
                SettingsBloc bloc = context.read();
                bloc.add(UpdateSettings((settings) {
                  settings.paths.qlcplus = path;

                  return settings;
                }));
              }),
          PathSettingRow(
              label: "GDTF".i18n,
              value: settings.paths.gdtf,
              update: (path) {
                SettingsBloc bloc = context.read();
                bloc.add(UpdateSettings((settings) {
                  settings.paths.gdtf = path;

                  return settings;
                }));
              }),
          PathSettingRow(
              label: "Mizer".i18n,
              value: settings.paths.mizer,
              update: (path) {
                SettingsBloc bloc = context.read();
                bloc.add(UpdateSettings((settings) {
                  settings.paths.mizer = path;

                  return settings;
                }));
              }),
        ])
      ]);
    });
  }
}

class PathsSetting extends StatelessWidget {
  final List<String> paths;
  final Function(List<String>) update;

  const PathsSetting({required this.paths, required this.update, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ...paths.mapEnumerated((path, i) {
        return Row(
          children: [
            Expanded(
              child: PathSetting(
                  value: path,
                  update: (p) {
                    update(paths.mapEnumerated((p, j) => i == j ? p : p).toList());
                  }),
            ),
            SettingsButton(
                symmetric: true,
                child: Icon(
                  Icons.close,
                  size: 12,
                ),
                onTap: () {
                  update(paths.whereIndexed((_, j) => i != j).toList());
                })
          ],
        );
      }),
      SettingsButton(
          child: Text("Add Path"),
          onTap: () async {
            final path = await getDirectoryPath();
            if (path == null) {
              return;
            }
            update([...paths, path]);
          })
    ]);
  }
}

class PathSettingRow extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) update;

  const PathSettingRow({required this.label, required this.value, required this.update, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SettingsRow(label, [Expanded(child: PathSetting(value: value, update: update))]),
    );
  }
}

class PathSetting extends StatefulWidget {
  final String value;
  final Function(String) update;

  const PathSetting({required this.value, required this.update, super.key});

  @override
  State<PathSetting> createState() => _PathSettingState();
}

class _PathSettingState extends State<PathSetting> {
  final FocusNode focusNode = FocusNode(debugLabel: "PathSetting");
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value;
  }

  @override
  void didUpdateWidget(PathSetting oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value == widget.value || widget.value == controller.text) {
      return;
    }
    controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(2),
              child: EditableText(
                focusNode: focusNode,
                controller: controller,
                textAlign: TextAlign.start,
                cursorColor: Colors.black87,
                backgroundCursorColor: Colors.black12,
                style: textStyle,
                selectionColor: Colors.black38,
                keyboardType: TextInputType.text,
                autofocus: true,
                inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                onChanged: (path) => widget.update(path),
              ),
            )),
        Container(
          width: 4,
        ),
        SettingsButton(
            child: Text("..."),
            onTap: () async {
              final path = await getDirectoryPath(initialDirectory: widget.value);
              if (path == null) {
                return;
              }
              widget.update(path);
            })
      ]),
    );
  }
}

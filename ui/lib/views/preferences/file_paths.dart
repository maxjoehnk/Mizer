import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/settings.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/state/settings_bloc.dart';
import 'package:mizer/widgets/hoverable.dart';

import 'preferences.dart';

class PathSettings extends StatelessWidget {
  const PathSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, Settings>(builder: (context, settings) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        PathSetting(label: "Midi Device Profiles".i18n, value: settings.paths.midiDeviceProfiles, update: (path) {
          SettingsBloc bloc = context.read();
          bloc.add(UpdateSettings((settings) {
            settings.paths.midiDeviceProfiles = path;

            return settings;
          }));
        }),
        PreferencesCategory(label: "Fixture Libraries".i18n, children: [
          PathSetting(label: "Open Fixture Library".i18n, value: settings.paths.openFixtureLibrary, update: (path) {
            SettingsBloc bloc = context.read();
            bloc.add(UpdateSettings((settings) {
              settings.paths.openFixtureLibrary = path;

              return settings;
            }));
          }),
          PathSetting(label: "QLC+".i18n, value: settings.paths.qlcplus, update: (path) {
            SettingsBloc bloc = context.read();
            bloc.add(UpdateSettings((settings) {
              settings.paths.qlcplus = path;

              return settings;
            }));
          }),
          PathSetting(label: "GDTF".i18n, value: settings.paths.gdtf, update: (path) {
            SettingsBloc bloc = context.read();
            bloc.add(UpdateSettings((settings) {
              settings.paths.gdtf = path;

              return settings;
            }));
          }),
        ])
      ]);
    });
  }
}

class PathSetting extends StatefulWidget {
  final String label;
  final String value;
  final Function(String) update;

  const PathSetting({required this.label, required this.value, required this.update, Key? key}) : super(key: key);

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
    print("${oldWidget.value} ${widget.value} ${oldWidget.value == widget.value}");
    if (oldWidget.value == widget.value || widget.value == controller.text) {
      return;
    }
    controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText2!;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SettingsRow(widget.label, [
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
        Hoverable(
            builder: (hover) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text("..."),
                ),
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

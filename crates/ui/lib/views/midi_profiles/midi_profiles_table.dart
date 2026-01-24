import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/settings.pb.dart';
import 'package:mizer/state/midi_profiles_bloc.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

class MidiProfilesTable extends StatelessWidget {
  final List<MidiDeviceProfile> profiles;

  const MidiProfilesTable({super.key, required this.profiles});

  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "MIDI Device Profiles".i18n,
      child: MizerTable(
        columns: [
          Text("Manufacturer".i18n, style: titleTheme),
          Text("Name".i18n, style: titleTheme),
          Text("Errors".i18n, style: titleTheme),
          Text("File Path".i18n, style: titleTheme),
        ],
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FixedColumnWidth(100),
          3: FlexColumnWidth(2),
        },
        rows: this.profiles.map((profile) => MizerTableRow(cells: [
          Text(profile.manufacturer),
          Text(profile.name),
          Text("${profile.errors.length}"),
          Text(profile.filePath),
        ])).toList(),
      ),
      actions: [
        PanelActionModel(label: "Reload".i18n, onClick: () {
          context.read<MidiProfilesBloc>().add(ReloadMidiProfiles());
        })
      ],
    );
  }
}

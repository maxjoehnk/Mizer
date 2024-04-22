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
      label: "MIDI Device Profiles",
      child: MizerTable(
        columns: [
          Text("Manufacturer", style: titleTheme),
          Text("Name", style: titleTheme),
          Text("Errors", style: titleTheme),
          Text("File Path", style: titleTheme),
        ],
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(0.5),
          3: FlexColumnWidth(4),
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

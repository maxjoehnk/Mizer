import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

class MidiConnectionsView extends StatefulWidget {
  final List<Connection> connections;
  final List<MidiDeviceProfile> deviceProfiles;
  final Function() onRefresh;

  const MidiConnectionsView({super.key, required this.connections, required this.onRefresh, required this.deviceProfiles});

  @override
  State<MidiConnectionsView> createState() => _MidiConnectionsViewState();
}

class _MidiConnectionsViewState extends State<MidiConnectionsView> {
  @override
  Widget build(BuildContext context) {
    var titleTheme = TextStyle(fontWeight: FontWeight.bold);

    return Panel(
      label: "MIDI Connections".i18n,
      child: MizerTable(
        columns: [
          Text("Name".i18n, style: titleTheme),
          Text("Device Profile".i18n, style: titleTheme),
        ],
          rows: _connections.map((c) => MizerTableRow(cells: [
            Text(c.name),
            MizerSelect(
                value: c.midi.deviceProfile,
                options: widget.deviceProfiles
                    .map((dp) => SelectOption(value: dp.id, label: dp.model))
                    .toList(),
                onChanged: (e) {})
          ])).toList()),
    );
  }

  ConnectionsApi get api {
    return context.read();
  }

  Iterable<Connection> get _connections {
    return widget.connections.where((c) => c.hasMidi());
  }
}

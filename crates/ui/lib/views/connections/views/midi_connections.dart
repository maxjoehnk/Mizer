import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/dialogs/midi_monitor.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/controls/select.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/table/table.dart';
import 'package:provider/provider.dart';

class MidiConnectionsView extends StatefulWidget {
  final List<Connection> connections;
  final List<MidiDeviceProfile> deviceProfiles;
  final Function() onRefresh;

  const MidiConnectionsView(
      {super.key,
      required this.connections,
      required this.onRefresh,
      required this.deviceProfiles});

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
          columnWidths: {
            2: FixedColumnWidth(64),
          },
          columns: [
            Text("Name".i18n, style: titleTheme),
            Text("Device Profile".i18n, style: titleTheme),
            Container(),
          ],
          rows: _connections
              .map((c) => MizerTableRow(cells: [
                    Text(c.name),
                    MizerSelect(
                        value: c.midi.deviceProfile,
                        options: widget.deviceProfiles
                            .map((dp) => SelectOption(value: dp.id, label: dp.model))
                            .toList(),
                        onChanged: (e) {
                          api.changeMidiDeviceProfile(c.name, e)
                            .then((_) => widget.onRefresh());
                        }),
                    MizerIconButton(
                        icon: MdiIcons.formatListBulleted,
                        label: "Monitor".i18n,
                        onClick: () => _showMidiMonitor(context, c))
                  ]))
              .toList()),
    );
  }

  _showMidiMonitor(BuildContext context, Connection connection) {
    openDialog(context, MidiMonitorDialog(connection));
  }

  ConnectionsApi get api {
    return context.read();
  }

  Iterable<Connection> get _connections {
    return widget.connections.where((c) => c.hasMidi());
  }

  // TODO: integrate preview again
  Widget _deviceLayout(MidiConnection connection) {
    var deviceProfile = widget.deviceProfiles
        .firstWhereOrNull((deviceProfile) => deviceProfile.id == connection.deviceProfile);
    if (deviceProfile == null || !deviceProfile.hasLayout() || deviceProfile.layout.isEmpty) {
      return Container();
    }
    return SvgPicture.string(deviceProfile.layout, height: 128);
  }
}

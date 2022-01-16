import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/panel.dart';

import 'dialogs/add_artnet_connection.dart';
import 'dialogs/add_sacn_connection.dart';
import 'dialogs/dmx_monitor.dart';
import 'dialogs/midi_monitor.dart';
import 'types/helios_connection.dart';
import 'types/midi_connection.dart';
import 'types/osc_connection.dart';
import 'types/prodjlink_connection.dart';

class ConnectionsView extends StatefulWidget {
  @override
  State<ConnectionsView> createState() => _ConnectionsViewState();
}

class _ConnectionsViewState extends State<ConnectionsView> {
  List<Connection> connections = [];
  List<MidiDeviceProfile> midiDeviceProfiles = [];

  @override
  Widget build(BuildContext context) {
    return Panel(
        label: "Connections",
        child: ListView.builder(
            itemCount: connections.length,
            itemBuilder: (context, index) {
              var connection = connections[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ConnectionTag(connection),
                      ),
                      Expanded(child: DeviceTitle(connection)),
                      ..._buildActions(context, connection),
                    ],
                  ),
                  _buildConnection(connection),
                  Divider(),
                ],
              );
            }),
        actions: [
          PanelAction(label: "Add sACN", onClick: _addSacn),
          PanelAction(label: "Add Artnet", onClick: _addArtnet),
        ]);
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void activate() {
    super.activate();
    _fetch();
  }

  @override
  void reassemble() {
    super.reassemble();
    _fetch();
  }

  List<Widget> _buildActions(BuildContext context, Connection connection) {
    if (connection.hasDmx()) {
      return [
        MizerIconButton(
            icon: MdiIcons.chartBar,
            label: "Monitor",
            onClick: () => _showDmxMonitor(context, connection))
      ];
    }
    if (connection.hasOsc()) {
      return [MizerIconButton(icon: MdiIcons.formatListBulleted, label: "Monitor")];
    }
    if (connection.hasMidi()) {
      return [MizerIconButton(
          icon: MdiIcons.formatListBulleted,
          label: "Monitor",
          onClick: () => _showMidiMonitor(context, connection))
      ];
    }
    return [];
  }

  Widget _buildConnection(Connection connection) {
    if (connection.hasProDJLink()) {
      return ProDJLinkConnectionView(device: connection.proDJLink);
    }
    if (connection.hasHelios()) {
      return HeliosConnectionView(device: connection.helios);
    }
    if (connection.hasOsc()) {
      return OscConnectionView(device: connection.osc);
    }
    if (connection.hasMidi()) {
      return MidiConnectionView(device: connection.midi, deviceProfiles: midiDeviceProfiles);
    }
    return Container();
  }

  _showDmxMonitor(BuildContext context, Connection connection) {
    openDialog(context, DmxMonitorDialog(connection));
  }

  _showMidiMonitor(BuildContext context, Connection connection) {
    openDialog(context, MidiMonitorDialog(connection));
  }

  _fetch() async {
    await _fetchConnections();
    await _fetchMidiDeviceProfiles();
  }

  Future<void> _fetchConnections() async {
    var connections = await api.getConnections();
    this.setState(() {
      this.connections = connections.connections;
    });
  }

  Future<void> _fetchMidiDeviceProfiles() async {
    var deviceProfiles = await api.getMidiDeviceProfiles();
    this.setState(() {
      this.midiDeviceProfiles = deviceProfiles.profiles;
    });
  }

  _addSacn() async {
    var value = await showDialog<AddSacnRequest>(
        context: context, builder: (context) => AddSacnConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addSacn(value);
    await _fetch();
  }

  _addArtnet() async {
    var value = await showDialog<AddArtnetRequest>(
        context: context, builder: (context) => AddArtnetConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addArtnet(value);
    await _fetch();
  }

  ConnectionsApi get api {
    return context.read();
  }
}

class ConnectionTag extends StatelessWidget {
  final Connection connection;

  ConnectionTag(this.connection);

  @override
  Widget build(BuildContext context) {
    if (connection.hasDmx()) {
      return _tag("DMX");
    }
    if (connection.hasProDJLink()) {
      return _tag("ProDJLink");
    }
    if (connection.hasHelios()) {
      return _tag("Helios");
    }
    if (connection.hasEtherDream()) {
      return _tag("Ether Dream");
    }
    if (connection.hasGamepad()) {
      return _tag("Gamepad");
    }
    if (connection.hasOsc()) {
      return _tag("OSC");
    }
    if (connection.hasMidi()) {
      return _tag("Midi");
    }
    return Container();
  }

  Widget _tag(String text) {
    return SizedBox(
      width: 96,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white54),
          ),
          padding: const EdgeInsets.all(4),
          child: Text(text, textAlign: TextAlign.center)),
    );
  }
}

class DeviceTitle extends StatelessWidget {
  final Connection connection;

  DeviceTitle(this.connection);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(connection.name),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/views/dmx_connections.dart';
import 'package:mizer/views/connections/views/gamepad_connections.dart';
import 'package:mizer/views/connections/views/midi_connections.dart';
import 'package:mizer/views/connections/views/mqtt_connections.dart';
import 'package:mizer/views/connections/views/osc_connections.dart';
import 'package:mizer/views/connections/views/prodjlink_connections.dart';
import 'package:mizer/widgets/list_item.dart';
import 'package:mizer/widgets/panel.dart';

class ConnectionsView extends StatefulWidget {
  @override
  State<ConnectionsView> createState() => _ConnectionsViewState();
}

class _ConnectionsViewState extends State<ConnectionsView> {
  ConnectionCategory category = ConnectionCategory.Dmx;
  List<Connection> connections = [];
  List<MidiDeviceProfile> midiDeviceProfiles = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConnectionCategoryList(selected: category, onSelect: (c) => setState(() => category = c)),
        if (category == ConnectionCategory.Dmx)
          Expanded(child: DmxConnectionsView(connections: connections, onRefresh: _fetch)),
        if (category == ConnectionCategory.Midi)
          Expanded(child: MidiConnectionsView(connections: connections, deviceProfiles: midiDeviceProfiles, onRefresh: _fetch)),
        if (category == ConnectionCategory.Osc)
          Expanded(child: OscConnectionsView(connections: connections, onRefresh: _fetch)),
        if (category == ConnectionCategory.Mqtt)
          Expanded(child: MqttConnectionsView(connections: connections, onRefresh: _fetch)),
        if (category == ConnectionCategory.Laser)
          Expanded(child: Placeholder()),
        if (category == ConnectionCategory.Gamepads)
          Expanded(child: GamepadConnectionsView(connections: connections)),
        if (category == ConnectionCategory.ProDjLink)
          Expanded(child: ProDJLinkConnectionsView(connections: connections)),
      ]
    );
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

  ConnectionsApi get api {
    return context.read();
  }
}

enum ConnectionCategory {
  Dmx,
  Midi,
  Osc,
  Laser,
  Gamepads,
  ProDjLink,
  Mqtt,
  Citp,
  Video,
}

final Map<ConnectionCategory, String> categoryNames = {
  ConnectionCategory.Dmx: "DMX",
  ConnectionCategory.Midi: "MIDI",
  ConnectionCategory.Osc: "OSC",
  ConnectionCategory.Laser: "Laser",
  ConnectionCategory.Gamepads: "Gamepads",
  ConnectionCategory.ProDjLink: "Pro DJ Link",
  ConnectionCategory.Mqtt: "MQTT",
  ConnectionCategory.Citp: "CITP",
  ConnectionCategory.Video: "Video Sources",
};

class ConnectionCategoryList extends StatelessWidget {
  final ConnectionCategory selected;
  final Function(ConnectionCategory) onSelect;

  const ConnectionCategoryList({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, child: Panel(
      label: "Connection Types".i18n,
          child: ListView(
              children: ConnectionCategory.values
                  .map((c) => ListItem(
                      child: Text(categoryNames[c]!),
                      onTap: () => onSelect(c),
                      selected: selected == c))
                  .toList()),
        ));
  }
}

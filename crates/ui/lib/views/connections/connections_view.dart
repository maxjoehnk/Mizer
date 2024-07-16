import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:provider/provider.dart';

import 'connection_categories.dart';
import 'views/citp_connections.dart';
import 'views/dmx_connections.dart';
import 'views/gamepad_connections.dart';
import 'views/hid_connections.dart';
import 'views/laser_connections.dart';
import 'views/midi_connections.dart';
import 'views/mqtt_connections.dart';
import 'views/osc_connections.dart';
import 'views/prodjlink_connections.dart';
import 'views/video_connections.dart';

class ConnectionsView extends StatefulWidget {
  @override
  State<ConnectionsView> createState() => _ConnectionsViewState();
}

class _ConnectionsViewState extends State<ConnectionsView> {
  ConnectionCategory category = ConnectionCategory.Dmx;
  List<Connection> connections = [];
  List<MidiDeviceProfile> midiDeviceProfiles = [];
  late Timer timer;

  _ConnectionsViewState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ConnectionCategoryList(
          selected: category,
          connections: connections,
          onSelect: (c) => setState(() => category = c)),
      if (category == ConnectionCategory.Dmx)
        Expanded(child: DmxConnectionsView(connections: connections, onRefresh: _fetch)),
      if (category == ConnectionCategory.Midi)
        Expanded(
            child: MidiConnectionsView(
                connections: connections, deviceProfiles: midiDeviceProfiles, onRefresh: _fetch)),
      if (category == ConnectionCategory.Osc)
        Expanded(child: OscConnectionsView(connections: connections, onRefresh: _fetch)),
      if (category == ConnectionCategory.Mqtt)
        Expanded(child: MqttConnectionsView(connections: connections, onRefresh: _fetch)),
      if (category == ConnectionCategory.Laser)
        Expanded(child: LaserConnectionsView(connections: connections)),
      if (category == ConnectionCategory.GameControllers)
        Expanded(child: GamepadConnectionsView(connections: connections)),
      if (category == ConnectionCategory.ProDjLink)
        Expanded(child: ProDJLinkConnectionsView(connections: connections)),
      if (category == ConnectionCategory.Citp)
        Expanded(child: CitpConnectionsView(connections: connections)),
      if (category == ConnectionCategory.Video)
        Expanded(child: VideoConnectionsView(connections: connections)),
      if (category == ConnectionCategory.HID)
        Expanded(child: HidConnectionsView(connections: connections)),
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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

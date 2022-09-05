import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/platform/context_menu.dart';

import 'dialogs/add_artnet_connection.dart';
import 'dialogs/add_mqtt_connection.dart';
import 'dialogs/add_sacn_connection.dart';
import 'dialogs/dmx_monitor.dart';
import 'dialogs/midi_monitor.dart';
import 'types/helios_connection.dart';
import 'types/midi_connection.dart';
import 'types/mqtt_connection.dart';
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
        label: "Connections".i18n,
        child: ListView.builder(
            itemCount: connections.length,
            itemBuilder: (context, index) {
              var connection = connections[index];
              return ContextMenu(
                menu: Menu(items: [
                  if (connection.canConfigure) MenuItem(
                      label: "Configure".i18n,
                      action: () => _onConfigure(connection)),
                  if (connection.canDelete) MenuItem(
                      label: "Delete".i18n,
                      action: () => _onDelete(connection)),
                ]),
                child: Column(
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
                ),
              );
            }),
        actions: [
          PanelAction(label: "Add sACN".i18n, onClick: _addSacn),
          PanelAction(label: "Add Artnet".i18n, onClick: _addArtnet),
          PanelAction(label: "Add MQTT".i18n, onClick: _addMqtt),
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
            label: "Monitor".i18n,
            onClick: () => _showDmxMonitor(context, connection))
      ];
    }
    if (connection.hasOsc()) {
      return [MizerIconButton(icon: MdiIcons.formatListBulleted, label: "Monitor".i18n)];
    }
    if (connection.hasMidi()) {
      return [MizerIconButton(
          icon: MdiIcons.formatListBulleted,
          label: "Monitor".i18n,
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
    if (connection.hasMqtt()) {
      return MqttConnectionView(connection: connection.mqtt);
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
    var value = await showDialog<SacnConfig>(
        context: context, builder: (context) => ConfigureSacnConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addSacn(value);
    await _fetch();
  }

  _addArtnet() async {
    var value = await showDialog<ArtnetConfig>(
        context: context, builder: (context) => ConfigureArtnetConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addArtnet(value);
    await _fetch();
  }

  _addMqtt() async {
    var value = await showDialog<MqttConnection>(
        context: context, builder: (context) => ConfigureMqttConnectionDialog());
    if (value == null) {
      return null;
    }
    await api.addMqtt(value);
    await _fetch();
  }

  _onDelete(Connection connection) async {
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: Text("Delete Connection".i18n),
              content: SingleChildScrollView(
                child: Text("Delete Connection ${connection.name}?".i18n),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel".i18n),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  autofocus: true,
                  child: Text("Delete".i18n),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
    if (result) {
      await api.deleteConnection(connection);
      await _fetch();
    }
  }

  _onConfigure(Connection connection) async {
    if (connection.hasDmx() && connection.dmx.hasArtnet()) {
      var value = await showDialog<ArtnetConfig>(
          context: context, builder: (context) => ConfigureArtnetConnectionDialog(config: connection.dmx.artnet));
      if (value == null) {
        return null;
      }
      await api.configureConnection(ConfigureConnectionRequest(dmx: DmxConnection(artnet: value, outputId: connection.dmx.outputId)));
      await _fetch();
    }
    if (connection.hasMqtt()) {
      var value = await showDialog<MqttConnection>(
          context: context, builder: (context) => ConfigureMqttConnectionDialog(config: connection.mqtt));
      if (value == null) {
        return null;
      }
      value.connectionId = connection.mqtt.connectionId;
      await api.configureConnection(ConfigureConnectionRequest(mqtt: value));
      await _fetch();
    }
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
    if (connection.hasMqtt()) {
      return _tag("MQTT");
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

extension ConnectionExtensions on Connection {
  bool get canConfigure {
    return (this.hasDmx() && this.dmx.hasArtnet()) || this.hasOsc() || this.hasMqtt();
  }

  bool get canDelete {
    return this.hasDmx() || this.hasOsc() || this.hasMqtt();
  }
}

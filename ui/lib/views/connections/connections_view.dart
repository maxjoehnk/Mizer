import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/views/connections/dialogs/dmx_monitor.dart';
import 'package:mizer/views/connections/types/helios_connection.dart';
import 'package:mizer/views/connections/types/midi_connection.dart';
import 'package:mizer/views/connections/types/osc_connection.dart';
import 'package:mizer/views/connections/types/prodjlink_connection.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/panel.dart';

class ConnectionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConnectionsApi api = context.read();
    return FutureBuilder(
        future: api.getConnections(),
        initialData: Connections(),
        builder: (context, snapshot) {
          Connections connections = snapshot.data;
          return Panel(
            label: "Connections",
            child: ListView.builder(
                itemCount: connections.connections.length,
                itemBuilder: (context, index) {
                  var connection = connections.connections[index];
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
              PanelAction(label: "Add sACN"),
              PanelAction(label: "Add Artnet"),
            ]
          );
        });
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
      return [MizerIconButton(icon: MdiIcons.formatListBulleted, label: "Monitor")];
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
      return MidiConnectionView(device: connection.midi);
    }
    return Container();
  }

  _showDmxMonitor(BuildContext context, Connection connection) {
    openDialog(context, DmxMonitorDialog(connection));
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

import 'package:flutter/material.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/list_item.dart';
import 'package:mizer/widgets/panel.dart';

enum ConnectionCategory {
  Dmx,
  Midi,
  Osc,
  Laser,
  GameControllers,
  ProDjLink,
  Mqtt,
  Citp,
  Video,
  HID,
}

final Map<ConnectionCategory, String> categoryNames = {
  ConnectionCategory.Dmx: "DMX",
  ConnectionCategory.Midi: "MIDI",
  ConnectionCategory.Osc: "OSC",
  ConnectionCategory.Laser: "Laser",
  ConnectionCategory.GameControllers: "Game Controllers",
  ConnectionCategory.ProDjLink: "Pro DJ Link",
  ConnectionCategory.Mqtt: "MQTT",
  ConnectionCategory.Citp: "CITP",
  ConnectionCategory.Video: "Video Sources",
  ConnectionCategory.HID: "HID Devices",
};

class ConnectionCategoryList extends StatelessWidget {
  final ConnectionCategory selected;
  final List<Connection> connections;
  final Function(ConnectionCategory) onSelect;

  const ConnectionCategoryList(
      {super.key, required this.selected, required this.onSelect, required this.connections});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Panel(
          label: "Connection Types".i18n,
          child: ListView(
              children: ConnectionCategory.values
                  .map((c) => ListItem(
                      child: Text("${categoryNames[c]!} (${connections.getByCategory(c).length})"),
                      onTap: () => onSelect(c),
                      selected: selected == c))
                  .toList()),
        ));
  }
}

extension ConnectionCategoryExt on List<Connection> {
  Iterable<Connection> getByCategory(ConnectionCategory category) {
    switch (category) {
      case ConnectionCategory.Dmx:
        return where((c) => c.hasDmxOutput() || c.hasDmxInput());
      case ConnectionCategory.Midi:
        return where((c) => c.hasMidi());
      case ConnectionCategory.Osc:
        return where((c) => c.hasOsc());
      case ConnectionCategory.Laser:
        return where((c) => c.hasHelios() || c.hasEtherDream());
      case ConnectionCategory.GameControllers:
        return where((c) => c.hasGamepad());
      case ConnectionCategory.ProDjLink:
        return where((c) => c.hasCdj() || c.hasDjm());
      case ConnectionCategory.Mqtt:
        return where((c) => c.hasMqtt());
      case ConnectionCategory.Citp:
        return where((c) => c.hasCitp());
      case ConnectionCategory.HID:
        return where((c) => c.hasX1() || c.hasG13());
      case ConnectionCategory.Video:
        return where((c) => c.hasNdiSource() || c.hasWebcam());
    }
  }
}

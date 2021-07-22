import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/extensions/map_extensions.dart';
import 'package:mizer/protos/connections.pb.dart';
import 'package:mizer/widgets/dialog/dialog.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/windows/dmx_monitor_window.dart';
import 'package:provider/provider.dart';

class DmxMonitorDialog implements DialogBuilder {
  final Connection connection;

  DmxMonitorDialog(this.connection);

  @override
  WidgetBuilder widgetBuilder() {
    return (context) => Center(child: Card(child: DmxMonitor(connection)));
  }

  @override
  toInitData() {
    return DmxMonitorWindow.toInitData(connection);
  }
}

class DmxMonitor extends StatefulWidget {
  final Connection connection;

  DmxMonitor(this.connection);

  @override
  State<DmxMonitor> createState() => _DmxMonitorState();
}

class _DmxMonitorState extends State<DmxMonitor> {
  int universe = 1;

  @override
  Widget build(BuildContext context) {
    var connections = context.read<ConnectionsApi>();
    var channels = Stream.periodic(Duration(milliseconds: 16))
        .asyncMap((event) => connections.monitorDmxConnection(widget.connection.dmx.outputId));
    return StreamBuilder<Map<int, List<int>>>(
      stream: channels,
      initialData: {},
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error loading dmx monitor ${snapshot.error}");
        }
        var universes = snapshot.data.keys.toList();
        universes.sort();
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              LimitedBox(
                  maxWidth: 144,
                  child:
                      UniverseSelector(universes: universes, universe: universe, onSelect: (u) => setState(() => universe = u))),
              Expanded(child: AddressObserver(channels: snapshot.data[universe])),
              LimitedBox(maxWidth: 250, child: AddressHistory()),
            ],
          ),
        );
      },
    );
  }
}

class UniverseSelector extends StatelessWidget {
  final int universe;
  final List<int> universes;
  final Function(int) onSelect;

  const UniverseSelector({Key key, this.universes, this.universe, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonitorGroup(
      title: "Universes",
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: universes
                .map((u) => Universe(
                      universe: u,
                      selected: universe == u,
                      onClick: () => onSelect(u),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class Universe extends StatelessWidget {
  final int universe;
  final bool selected;
  final Function() onClick;

  const Universe({Key key, this.universe, this.selected, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onClick: onClick,
      builder: (hovered) => Container(
          alignment: Alignment.center,
          width: 40,
          height: 40,
          color: (hovered || selected) ? Colors.deepOrangeAccent : null,
          child: Text(this.universe.toString())),
    );
  }
}

class AddressObserver extends StatelessWidget {
  final List<int> channels;

  const AddressObserver({Key key, this.channels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonitorGroup(title: "DMX", children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: channels.asMap().mapToList((index, value) {
              var percentage = value / 255;
              log("$percentage%");
              return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.deepOrangeAccent,
                    Colors.black12,
                  ], stops: [
                    percentage,
                    percentage,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text("${index + 1}"));
            })),
      )
    ]);
  }
}

class AddressHistory extends StatelessWidget {
  const AddressHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonitorGroup(
      title: "History",
      children: [],
    );
  }
}

class MonitorGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const MonitorGroup({this.title, this.children, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: Text(title), color: Colors.black87, padding: const EdgeInsets.all(4)),
          ...children,
        ],
      ),
    );
  }
}

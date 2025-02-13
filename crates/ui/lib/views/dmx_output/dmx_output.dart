import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/connections.dart';
import 'package:mizer/extensions/map_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class DmxOutputView extends StatelessWidget {
  const DmxOutputView({super.key});

  @override
  Widget build(BuildContext context) {
    return DmxMonitor();
  }
}

class DmxMonitor extends StatefulWidget {
  DmxMonitor();

  @override
  State<DmxMonitor> createState() => _DmxMonitorState();
}

class _DmxMonitorState extends State<DmxMonitor> {
  int universe = 1;

  @override
  Widget build(BuildContext context) {
    var connections = context.read<ConnectionsApi>();
    var channels = Stream.periodic(Duration(milliseconds: 16)).asyncMap(
            (event) => connections.monitorDmxOutput());
    return StreamBuilder<Map<int, List<int>>>(
      stream: channels,
      initialData: {},
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error loading dmx monitor ${snapshot.error}");
        }
        var universes = snapshot.data?.keys.toList() ?? [];
        universes.sort();
        return Row(
          children: [
            LimitedBox(
                maxWidth: 144,
                child: UniverseSelector(
                    universes: universes,
                    universe: universe,
                    onSelect: (u) => setState(() => universe = u))),
            Expanded(child: AddressObserver(channels: snapshot.data?[universe] ?? [])),
          ],
        );
      },
    );
  }
}

class UniverseSelector extends StatelessWidget {
  final int universe;
  final List<int> universes;
  final Function(int) onSelect;

  const UniverseSelector(
      {Key? key, required this.universes, required this.universe, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
        label: "Universes".i18n,
        child: Padding(
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
        ));
  }
}

class Universe extends StatelessWidget {
  final int universe;
  final bool selected;
  final Function() onClick;

  const Universe({Key? key, required this.universe, required this.selected, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hoverable(
      onTap: onClick,
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

  const AddressObserver({Key? key, required this.channels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Panel(
        label: "DMX".i18n,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 4,
                runSpacing: 4,
                children: channels.asMap().mapToList((index, value) {
                  var percentage = value / 255;
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${index + 1}"),
                          Text("$value", style: textTheme.bodySmall),
                        ],
                      ));
                })),
          ),
        ));
  }
}

class AddressHistory extends StatelessWidget {
  const AddressHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(label: "History".i18n, child: Container());
  }
}

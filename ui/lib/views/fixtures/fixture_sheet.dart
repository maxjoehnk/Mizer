import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';

import 'channel_sheet.dart';
import 'dmx_sheet.dart';

class FixtureSheet extends StatefulWidget {
  final List<Fixture> fixtures;
  final FixturesApi api;

  const FixtureSheet({this.fixtures, this.api, Key key}) : super(key: key);

  @override
  State<FixtureSheet> createState() => _FixtureSheetState();
}

class _FixtureSheetState extends State<FixtureSheet> {
  Set<String> modifiedChannels = Set();
  Set<String> modifiedDmxChannels = Set();

  @override
  Widget build(BuildContext context) {
    return Panel(
        child: Tabs(
          children: [
            Tab(
                label: "Channels",
                child: ChannelSheet(
                    fixtures: widget.fixtures,
                    api: widget.api,
                    // TODO: implement when store is implemented
                    modifiedChannels: [],
                    onModifyChannel: (group) => setState(() => modifiedChannels.add(group.name)))),
            Tab(label: "Position", child: Container()),
            Tab(label: "Color", child: Container()),
            Tab(label: "Lens", child: Container()),
            Tab(
                label: "DMX",
                child: DMXSheet(
                  fixtures: widget.fixtures,
                  api: widget.api,
                  // TODO: implement when store is implemented
                  modifiedChannels: [],
                  onModifyChannel: (channel) =>
                      setState(() => modifiedDmxChannels.add(channel.name)),
                )),
          ],
        ),
        actions: [
          // TODO: implement
          // PanelAction(label: "Store"),
          // TODO: I'm not quite sure how this should be implemented
          // I could force the fixture sheet to override all other commands from nodes and sequences and remove this override with the clear button
          // I could remember the previous value when a fader is first touched and reset to it
          // I could reset to the default value
          // PanelAction(label: "Clear", disabled: !_hasModifications),
        ]);
  }
}

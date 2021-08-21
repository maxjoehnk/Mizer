import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/views/fixtures/position_sheet.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';

import 'beam_sheet.dart';
import 'channel_sheet.dart';
import 'color_sheet.dart';
import 'dimmer_sheet.dart';
import 'dmx_sheet.dart';
import 'gobo_sheet.dart';

class FixtureSheet extends StatefulWidget {
  final List<Fixture> fixtures;
  final ProgrammerApi api;

  const FixtureSheet({this.fixtures, this.api, Key key}) : super(key: key);

  @override
  State<FixtureSheet> createState() => _FixtureSheetState();
}

class _FixtureSheetState extends State<FixtureSheet> {
  Set<String> modifiedChannels = Set();
  Set<String> modifiedDmxChannels = Set();
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return Panel(
        child: Tabs(
          children: [
            Tab(label: "Dimmer", child: DimmerSheet(fixtures: widget.fixtures)),
            Tab(label: "Position", child: PositionSheet(fixtures: widget.fixtures)),
            Tab(label: "Gobo", child: GoboSheet(fixtures: widget.fixtures)),
            Tab(label: "Color", child: ColorSheet(fixtures: widget.fixtures)),
            Tab(label: "Beam", child: BeamSheet(fixtures: widget.fixtures)),
            Tab(
                label: "Channels",
                child: ChannelSheet(
                    fixtures: widget.fixtures,
                    // TODO: implement when store is implemented
                    modifiedChannels: [],
                    onModifyChannel: (group) => setState(() => modifiedChannels.add(group.name)))),
            Tab(
                label: "DMX",
                child: DMXSheet(
                  fixtures: widget.fixtures,
                  // TODO: implement when store is implemented
                  modifiedChannels: [],
                  onModifyChannel: (channel) =>
                      setState(() => modifiedDmxChannels.add(channel.name)),
                )),
          ],
        ),
        actions: [
          PanelAction(label: "Highlight", activated: highlight, onClick: () {
            setState(() {
              highlight = !highlight;
              widget.api.highlight(highlight);
            });
          }, disabled: widget.fixtures.isEmpty),
          // PanelAction(label: "Store"),
          PanelAction(label: "Clear", onClick: () => widget.api.clear(), disabled: widget.fixtures.isEmpty),
        ]);
  }
}

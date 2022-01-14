import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

const CONTROLS = [
  FixtureControl.PAN,
  FixtureControl.TILT,
];

const NAMES = {
  FixtureControl.PAN: "Pan",
  FixtureControl.TILT: "Tilt",
};

class PositionSheet extends StatelessWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;

  const PositionSheet({required this.fixtures, required this.channels, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controls.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children:
                  controls.map((control) => FixtureGroupControl(control)).toList())
          : null,
    );
  }

  Iterable<Control> get controls {
    if (fixtures.isEmpty) {
      return [];
    }
    return fixtures.first.controls
        .where((e) => CONTROLS.contains(e.control))
        .map((control) => Control(NAMES[control.control],
            fader: control.fader,
            channel: channels.firstWhereOrNull((channel) => channel.control == control.control),
            update: (v) => WriteControlRequest(
                  control: control.control,
                  fader: v,
                )));
  }
}

// @dart=2.11
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

const CONTROLS = [
  FixtureControl.INTENSITY,
  FixtureControl.SHUTTER,
];

const NAMES = {
  FixtureControl.INTENSITY: "Dimmer",
  FixtureControl.SHUTTER: "Shutter",
};

class DimmerSheet extends StatelessWidget {
  final List<Fixture> fixtures;

  const DimmerSheet({this.fixtures, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controls.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: controls
                  .map((control) => FixtureGroupControl(control, fixtures: fixtures))
                  .toList())
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
            update: (v) => WriteControlRequest(
                  control: control.control,
                  fader: v,
                )));
  }
}

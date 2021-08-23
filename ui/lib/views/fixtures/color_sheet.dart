import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/inputs/color.dart';

import 'fixture_group_control.dart';

const CONTROLS = [
  FixtureControl.COLOR,
  FixtureControl.FOCUS,
  FixtureControl.PRISM,
  FixtureControl.FROST,
  FixtureControl.IRIS,
];

const NAMES = {
  FixtureControl.ZOOM: "Zoom",
  FixtureControl.FOCUS: "Focus",
  FixtureControl.PRISM: "Prism",
  FixtureControl.FROST: "Frost",
  FixtureControl.IRIS: "Iris",
};

class ColorSheet extends StatelessWidget {
  final List<Fixture> fixtures;

  const ColorSheet({this.fixtures, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controls.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children:
                  controls.map((control) => FixtureGroupControl(control, fixtures: fixtures)).toList())
          : null,
    );
  }

  Iterable<Control> get controls {
    if (fixtures.isEmpty) {
      return [];
    }
    return fixtures.first.controls
        .where((control) => control.control == FixtureControl.COLOR)
        .map((control) => Control("Color",
            color: control.color,
            update: (v) {
              ColorValue value = v;
              return WriteControlRequest(
                  control: control.control,
                  color: ColorChannel(red: value.red, green: value.green, blue: value.blue),
                );
            }));
  }
}

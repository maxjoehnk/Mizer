import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'package:mizer/panes/programmer/sheets/fixture_group_control.dart';

const CONTROLS = [
  FixtureControl.GOBO,
];

final NAMES = {
  FixtureControl.GOBO: "Gobo",
};

class GoboSheet extends StatelessWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;

  const GoboSheet({required this.fixtures, required this.channels, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controls.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: controls.map((control) => FixtureGroupControl(control)).toList())
          : null,
    );
  }

  Iterable<Control> get controls {
    if (fixtures.isEmpty) {
      return [];
    }
    return fixtures.first.controls.where((e) => CONTROLS.contains(e.control)).map((control) =>
        Control(NAMES[control.control],
            fader: control.fader,
            control: control.control,
            presets: control.gobo.gobos
                .map((gobo) => ControlPreset(gobo.value, name: gobo.name, image: _goboImage(gobo)))
                .toList(),
            channel: channels.firstWhereOrNull((channel) => channel.control == control.control),
            update: (v) => WriteControlRequest(
                  control: control.control,
                  fader: v,
                )));
  }

  ControlPresetImage? _goboImage(Gobo gobo) {
    if (gobo.hasRaster()) {
      return ControlPresetImage(raster: Uint8List.fromList(gobo.raster));
    }
    if (gobo.hasSvg()) {
      return ControlPresetImage(svg: gobo.svg);
    }
    return null;
  }
}

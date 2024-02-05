import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/inputs/color.dart';

import 'fixture_group_control.dart';

const CONTROLS = [
  FixtureControl.COLOR_MIXER,
  FixtureControl.COLOR_WHEEL,
];

class ColorSheet extends StatelessWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;

  const ColorSheet({required this.fixtures, required this.channels, Key? key}) : super(key: key);

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
    return fixtures.first.controls
        .where((control) => CONTROLS.contains(control.control))
        .map((control) {
      if (control.control == FixtureControl.COLOR_MIXER) {
        return Control("Color",
            control: control.control,
            colorMixer: control.colorMixer,
            channel: channels.firstWhereOrNull((channel) => channel.control == control.control),
            update: (v) {
          ColorValue value = v;
          return WriteControlRequest(
            control: control.control,
            color: ColorMixerChannel(red: value.red, green: value.green, blue: value.blue),
          );
        });
      }
      if (control.control == FixtureControl.COLOR_WHEEL) {
        return Control("Color Wheel",
            control: control.control,
            fader: control.fader,
            presets: control.colorWheel.colors
                .map((color) => ControlPreset(color.value,
                    name: color.name, colors: color.colors))
                .toList(),
            channel: channels.firstWhereOrNull((channel) => channel.control == control.control),
            update: (v) => WriteControlRequest(
                  control: control.control,
                  fader: v,
                ));
      }
      throw new Exception("Invalid color control");
    });
  }
}

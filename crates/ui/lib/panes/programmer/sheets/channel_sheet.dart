import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

class ChannelSheet extends StatelessWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;
  final FixtureChannelCategory category;
  final bool useLabel;

  const ChannelSheet(
      {required this.fixtures, required this.channels, required this.category, this.useLabel = false, Key? key})
      : super(key: key);

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
        .where((e) => e.category == category)
        .map((control) => Control(useLabel ? control.label : control.channel,
            control: control,
            channel: channels.firstWhereOrNull((channel) => channel.control == control.channel),
            presets: control.presets.map((preset) {
              if (preset.hasImage()) {
                return ControlPreset(preset.value.percent,
                    name: preset.name, image: _fixtureImage(preset.image));
              }
              return ControlPreset(preset.value.percent, name: preset.name, colors: preset.colors);
            }).toList(),
            update: (v) => WriteControlRequest(
                  control: control.channel,
                  percent: v,
                )));
  }

  ControlPresetImage? _fixtureImage(FixtureImage image) {
    if (image.hasRaster()) {
      return ControlPresetImage(raster: Uint8List.fromList(image.raster));
    }
    if (image.hasSvg()) {
      return ControlPresetImage(svg: image.svg);
    }
    return null;
  }
}

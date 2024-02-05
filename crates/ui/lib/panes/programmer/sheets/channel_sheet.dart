import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

class ChannelSheet extends StatelessWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;

  const ChannelSheet({required this.fixtures, required this.channels, Key? key}) : super(key: key);

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
    return fixtures.first.controls.where((e) => e.control == FixtureControl.GENERIC).map((control) {
      var value =
          channels.firstWhereOrNull((channel) => channel.generic.name == control.generic.name);
      return Control(control.generic.name,
          generic: control.generic,
          control: control.control,
          channel: value,
          update: (v) => WriteControlRequest(
                control: control.control,
                generic: WriteControlRequest_GenericValue(value: v, name: control.generic.name),
              ));
    });
  }
}

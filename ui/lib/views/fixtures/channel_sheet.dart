import 'package:flutter/widgets.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

class ChannelSheet extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<String> modifiedChannels;
  final Function(FixtureChannelGroup) onModifyChannel;

  const ChannelSheet(
      {this.fixtures, this.modifiedChannels, this.onModifyChannel, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: groups.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: groups
                  .map((group) => FixtureGroupControl(group, fixtures: fixtures))
                  .toList())
          : null,
    );
  }

  List<FixtureChannelGroup> get groups {
    return fixtures.first.channels;
  }
}

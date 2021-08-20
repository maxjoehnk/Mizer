import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

class DimmerSheet extends StatelessWidget {
  final List<Fixture> fixtures;
  final FixturesApi api;

  const DimmerSheet({this.fixtures, this.api, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: groups.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: groups
                  .map((group) => FixtureGroupControl(group, api: api, fixtures: fixtures))
                  .toList())
          : null,
    );
  }

  Iterable<FixtureChannelGroup> get groups {
    return fixtures.first.channels.where((element) => element.hasIntensity() || element.hasShutter());
  }
}

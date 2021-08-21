import 'package:flutter/widgets.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

class BeamSheet extends StatelessWidget {
  final List<Fixture> fixtures;

  const BeamSheet({this.fixtures, Key key}) : super(key: key);

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

  Iterable<FixtureChannelGroup> get groups {
    if (fixtures.isEmpty) {
      return [];
    }
    return fixtures.first.channels.where((element) => element.hasZoom() || element.hasFocus() || element.hasPrism() || element.hasFrost() || element.hasIris());
  }
}

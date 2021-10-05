// @dart=2.11
import 'package:flutter/widgets.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'fixture_group_control.dart';

class GoboSheet extends StatelessWidget {
  final List<Fixture> fixtures;

  const GoboSheet({this.fixtures, Key key}) : super(key: key);

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
    return [];
  }
}

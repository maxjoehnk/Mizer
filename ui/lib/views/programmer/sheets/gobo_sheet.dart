import 'package:flutter/widgets.dart';
import 'package:mizer/protos/fixtures.extensions.dart';

import 'fixture_group_control.dart';

class GoboSheet extends StatelessWidget {
  final List<FixtureInstance> fixtures;

  const GoboSheet({required this.fixtures, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controls.isNotEmpty
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: controls
                  .map((control) => FixtureGroupControl(control))
                  .toList())
          : null,
    );
  }

  Iterable<Control> get controls {
    return [];
  }
}

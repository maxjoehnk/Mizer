import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/effects_bloc.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';

import 'programmer_control_list.dart';
import 'programmer_fixture_list.dart';

final NAMES = {
  FixtureControl.INTENSITY: "Dimmer",
  FixtureControl.SHUTTER: "Shutter",
  FixtureControl.COLOR_MIXER: "Color",
  FixtureControl.COLOR_WHEEL: "Color Wheel",
  FixtureControl.GOBO: "Gobo",
  FixtureControl.ZOOM: "Zoom",
  FixtureControl.FOCUS: "Focus",
  FixtureControl.PRISM: "Prism",
  FixtureControl.FROST: "Frost",
  FixtureControl.IRIS: "Iris",
};

class SmartViewWrapper extends StatelessWidget {
  const SmartViewWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(
        builder: (context, fixturesState) => BlocBuilder<PresetsBloc, PresetsState>(
            builder: (context, presetsState) => BlocBuilder<EffectsBloc, EffectState>(
                builder: (context, effectsState) => SmartView(
                    fixturesState: fixturesState,
                    presetsState: presetsState,
                    effectsState: effectsState))));
  }
}

class SmartView extends StatefulWidget {
  final Fixtures fixturesState;
  final PresetsState presetsState;
  final EffectState effectsState;

  const SmartView(
      {required this.fixturesState,
      required this.presetsState,
      required this.effectsState,
      Key? key})
      : super(key: key);

  @override
  State<SmartView> createState() => _SmartViewState();
}

class _SmartViewState extends State<SmartView>
    with SingleTickerProviderStateMixin, ProgrammerStateMixin {
  @override
  Widget build(BuildContext context) {
    var controls = _controls();
    return Column(children: [
      Expanded(
        child: ProgrammerFixtureList(
            fixtures: _fixtures(), programmerState: programmerState, api: context.read()),
      ),
      if (controls.isNotEmpty)
        Expanded(
            child: ProgrammerControlList(
                controls: controls,
                programmerState: programmerState,
                presetsState: widget.presetsState,
                effectsState: widget.effectsState)),
    ]);
  }

  List<FixtureEntry> _fixtures() {
    List<FixtureEntry> fixtures =
        widget.fixturesState.fixtures.map((fixture) => FixtureEntry(fixture: fixture)).toList();
    Iterable<FixtureEntry> subFixtures = widget.fixturesState.fixtures
        .map((fixture) => fixture.children
            .map((subFixture) => FixtureEntry(fixture: fixture, subFixture: subFixture)))
        .flattened;
    fixtures.addAll(subFixtures);

    return fixtures
        .where((fixture) =>
            programmerState.activeFixtures.contains(fixture.id) ||
            programmerState.fixtures.contains(fixture.id))
        .sortedByCompare<int>((fixture) {
      var fixtureIndex = programmerState.activeFixtures.indexOf(fixture.id);
      if (fixtureIndex == -1) {
        fixtureIndex = programmerState.fixtures.indexOf(fixture.id);
      }

      return fixtureIndex;
    }, (lhs, rhs) => lhs - rhs).toList();
  }

  List<FixtureControl> _controls() {
    return _fixtures().map((e) => e.controls).flattened.map((c) => c.control).toList();
  }
}

class FixtureEntry {
  SubFixture? subFixture;
  Fixture fixture;

  FixtureEntry({this.subFixture, required this.fixture});

  FixtureId get id {
    if (subFixture != null) {
      return FixtureId(subFixture: SubFixtureId(fixtureId: fixture.id, childId: subFixture!.id));
    }
    return FixtureId(fixture: fixture.id);
  }

  String get name {
    return subFixture?.name ?? fixture.name;
  }

  List<FixtureControls> get controls {
    return subFixture?.controls ?? fixture.controls;
  }
}

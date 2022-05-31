import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/programmer.dart';
import 'package:mizer/extensions/fixture_id_extensions.dart';
import 'package:mizer/extensions/programmer_channel_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

import '../presets/presets_view.dart';

const NAMES = {
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

class SmartView extends StatefulWidget {
  const SmartView({Key? key}) : super(key: key);

  @override
  State<SmartView> createState() => _SmartViewState();
}

class _SmartViewState extends State<SmartView> with SingleTickerProviderStateMixin {
  ProgrammerStatePointer? _pointer;
  Ticker? ticker;
  ProgrammerState programmerState = ProgrammerState();

  @override
  void initState() {
    super.initState();
    var programmerApi = context.read<ProgrammerApi>();
    programmerApi.getProgrammerPointer().then((pointer) {
      _pointer = pointer;
      ticker = this.createTicker((elapsed) {
        setState(() {
          programmerState = _pointer!.readState();
        });
      });
      ticker!.start();
    });
  }

  @override
  void dispose() {
    _pointer?.dispose();
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var channels = programmerState.controls
        .map((c) => c.control)
        .toSet()
        .sorted((a, b) => a.value - b.value);
    return BlocBuilder<FixturesBloc, Fixtures>(
      builder: (context, fixturesState) => BlocBuilder<PresetsBloc, PresetsState>(builder: (context, presetsState) {
        var controls = _controls(fixturesState);
        return Column(children: [
          ...controls
            .where((control) => [FixtureControl.INTENSITY, FixtureControl.COLOR_MIXER].contains(control))
            .toSet()
            .map((control) => Flexible(
              child: Panel(
              label: NAMES[control],
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Wrap(spacing: 4, runSpacing: 4, children: _presets(presetsState.presets, control)),
              ),
          ),
            )),
          Expanded(
            child: Panel(
              label: "Fixtures",
              actions: [
                PanelAction(label: "Highlight"),
                PanelAction(label: "Clear"),
              ],
              child: SingleChildScrollView(
                child: MizerTable(
                  columns: [Text("ID"), Text("Name"),
                    ...channels.map((c) => Text(NAMES[c]!))
                  ],
                  rows: _fixtures(fixturesState).map((f) => MizerTableRow(cells: [
                    Text(f.id.toDisplay()),
                    Text(f.name),
                    ...channels.map((control) => programmerState.controls.firstWhereOrNull((c) => control == c.control && c.fixtures.contains(f.id)))
                    .map((control) => control == null ? Text("") : Text(control.toDisplayValue()))
                  ])).toList(),
                ),
              ),
            ),
          )
        ]);
      }),
    );
  }

  List<FixtureEntry> _fixtures(Fixtures fixturesState) {
    List<FixtureEntry> fixtures = fixturesState.fixtures
        .map((fixture) => FixtureEntry(fixture: fixture))
        .toList();
    Iterable<FixtureEntry> subFixtures = fixturesState.fixtures
        .map((fixture) => fixture.children.map((subFixture) => FixtureEntry(fixture: fixture, subFixture: subFixture)))
        .flattened;
    fixtures.addAll(subFixtures);

    return fixtures
        .where((fixture) => programmerState.activeFixtures.contains(fixture.id) || programmerState.fixtures.contains(fixture.id))
        .toList();
  }

  List<FixtureControl> _controls(Fixtures fixturesState) {
    return _fixtures(fixturesState)
        .map((e) => e.controls)
        .flattened
        .map((c) => c.control)
        .toList();
  }

  List<Widget> _presets(Presets presetsState, FixtureControl control) {
    if (control == FixtureControl.INTENSITY) {
      return presetsState.intensities
          .map((preset) =>
          ColorButton(color: Colors.white.withOpacity(preset.fader), preset: preset))
      .toList();
    }
    if (control == FixtureControl.COLOR_MIXER) {
      return presetsState.color
          .map((preset) => ColorButton(
          color: Color.fromARGB(255, (preset.color.red * 255).toInt(),
              (preset.color.green * 255).toInt(), (preset.color.blue * 255).toInt()),
          preset: preset))
      .toList();
    }

    return <Widget>[];
  }
}

class FixtureEntry {
  SubFixture? subFixture;
  Fixture fixture;

  FixtureEntry({ this.subFixture, required this.fixture });

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

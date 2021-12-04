import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/fixtures_bloc.dart';

const LABELS = {
  CueControl.INTENSITY: 'Dimmer',
  CueControl.SHUTTER: 'Shutter',
  CueControl.COLOR_RED: 'Red',
  CueControl.COLOR_GREEN: 'Green',
  CueControl.COLOR_BLUE: 'Blue',
  CueControl.PAN: 'Pan',
  CueControl.TILT: 'Tilt',
  CueControl.FOCUS: 'Focus',
  CueControl.ZOOM: 'Zoom',
  CueControl.PRISM: 'Prism',
  CueControl.IRIS: 'Iris',
  CueControl.FROST: 'Frost',
  CueControl.GENERIC: 'Generic',
};

class CueContents extends StatelessWidget {
  final Cue cue;

  const CueContents({required this.cue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(
      builder: (context, fixtures) => SingleChildScrollView(
        child: DataTable(
            headingRowHeight: 40,
            dataRowHeight: 40,
            columns: [
              DataColumn(label: Text("Fixture ID")),
              DataColumn(label: Text("Name")),
              ..._controls.map((c) => DataColumn(label: Text(LABELS[c]!)))
            ],
            rows: _buildRows(fixtures.fixtures)),
      ),
    );
  }

  Iterable<CueControl> get _controls {
    List<CueControl> controls = cue.channels.map((e) => e.control).toSet().toList();
    controls.sort((lhs, rhs) => lhs.value.compareTo(rhs.value));

    return controls;
  }

  List<DataRow> _buildRows(List<Fixture> fixtures) {
    var channels = _controls;
    var fixtureIds = cue.channels
        .map((c) => c.fixtures)
        .fold<List<FixtureId>>([], (previousValue, element) => [...previousValue, ...element])
        .toSet()
        .toList();
    fixtureIds.sort((lhs, rhs) => lhs.compareTo(rhs));

    return fixtureIds.map((fixtureId) {
      var fixture = fixtures.getFixture(fixtureId);
      var fixtureChannels = channels
          .map((e) => cue.channels.firstWhereOrNull(
              (element) => element.control == e && element.fixtures.contains(fixtureId)))
          .toList();

      return DataRow(cells: [
        DataCell(Text(fixtureId.toDisplay())),
        DataCell(Text(fixture.name)),
        ...fixtureChannels.map((c) {
          if (c == null) {
            return DataCell(Container());
          }
          return DataCell(Text(c.value.hasDirect()
              ? c.value.direct.toPercentage()
              : "${c.value.range.from.toPercentage()} .. ${c.value.range.to.toPercentage()}"));
        })
      ]);
    }).toList();
  }
}

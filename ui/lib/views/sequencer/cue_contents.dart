import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/extensions/number_extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/fixtures_bloc.dart';

class CueContents extends StatelessWidget {
  final Cue cue;

  const CueContents({this.cue, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(
      builder: (context, fixtures) => DataTable(
          headingRowHeight: 40,
          dataRowHeight: 40,
          columns: [
            DataColumn(label: Text("Fixture ID")),
            DataColumn(label: Text("Name")),
            ..._channels.map((c) => DataColumn(label: Text(c)))
          ],
          rows: _buildRows(fixtures.fixtures)),
    );
  }

  Iterable<String> get _channels {
    return cue.channels.map((e) => e.channel).toSet();
  }

  List<DataRow> _buildRows(List<Fixture> fixtures) {
    var channels = _channels.toList();
    var fixtureIds = cue.channels
        .map((c) => c.fixtures)
        .fold([], (previousValue, element) => [...previousValue, ...element]).toSet();

    return fixtureIds.map((fixtureId) {
      var fixture = fixtures.firstWhere((element) => element.id == fixtureId);
      var fixtureChannels = channels
          .map((e) => cue.channels.firstWhere(
              (element) => element.channel == e && element.fixtures.contains(fixtureId),
              orElse: () => null))
          .toList();

      return DataRow(cells: [
        DataCell(Text(fixtureId.toString())),
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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/table/table.dart';

class FixtureTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<int> selectedIds;
  final Function(int, bool) onSelect;

  FixtureTable(
      {required this.fixtures,
      required this.selectedIds,
      required this.onSelect,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MizerTableRow> rows = _getRows();

    return SingleChildScrollView(
      child: MizerTable(columnWidths: {
        0: FixedColumnWidth(64),
        4: FixedColumnWidth(128),
      }, columns: const [
        Text("Id"),
        Text("Name"),
        Text("Manufacturer"),
        Text("Model"),
        Text("Mode"),
        Text("Address"),
      ], rows: rows),
    );
  }

  List<MizerTableRow> _getRows() {
    var fixtures =
        this.fixtures.sortedByCompare<int>((fixture) => fixture.id, (lhs, rhs) => lhs - rhs);
    List<MizerTableRow> rows = [];
    for (var fixture in fixtures) {
      rows.add(_fixtureRow(fixture));
    }
    return rows;
  }

  MizerTableRow _fixtureRow(Fixture fixture) {
    var selected = selectedIds.contains(fixture.id);
    var row = MizerTableRow(
      cells: [
        Text(fixture.id.toString()),
        Text(fixture.name),
        Text(fixture.manufacturer),
        Text(fixture.model),
        Text(fixture.mode),
        Text("${fixture.universe}:${fixture.channel} - ${fixture.channel + fixture.channelCount - 1}"),
      ],
      onTap: () => onSelect(fixture.id, !selected),
      selected: selected,
    );
    return row;
  }
}

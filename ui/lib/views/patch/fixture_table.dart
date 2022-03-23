import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/table/table.dart';

class FixtureTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<int> selectedIds;
  final Function(int, bool) onSelect;
  final Function(Fixture) onSelectSimilar;

  FixtureTable(
      {required this.fixtures,
      required this.selectedIds,
      required this.onSelect,
      required this.onSelectSimilar,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MizerTableRow> rows = _getRows();

    return SingleChildScrollView(
      child: MizerTable(columnWidths: {
        0: FixedColumnWidth(64),
      }, columns: const [
        Text("Id"),
        Text("Name"),
        Text("Address"),
        Text("Manufacturer"),
        Text("Model"),
        Text("Mode"),
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
        Text("${fixture.universe}.${fixture.channel.toString().padLeft(3, "0")}"),
        Text(fixture.manufacturer),
        Text(fixture.model),
        Text(fixture.mode),
      ],
      onTap: () => onSelect(fixture.id, !selected),
      onDoubleTap: () => onSelectSimilar(fixture),
      selected: selected,
    );
    return row;
  }
}

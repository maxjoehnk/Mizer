import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/table/table.dart';

class FixtureTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<FixtureId> selectedIds;
  final List<int> expandedIds;
  final Function(FixtureId, bool) onSelect;
  final Function(int) onExpand;
  final Function(Fixture) onSelectSimilar;
  final Function(Fixture) onSelectChildren;

  FixtureTable(
      {required this.fixtures,
      required this.selectedIds,
      required this.expandedIds,
      required this.onSelect,
      required this.onExpand,
      required this.onSelectSimilar,
      required this.onSelectChildren,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MizerTableRow> rows = _getRows();

    return SingleChildScrollView(
      child: MizerTable(columnWidths: {
        0: FixedColumnWidth(64),
      }, columns: const [
        Text(""),
        Text("Id"),
        Text("Manufacturer"),
        Text("Model"),
        Text("Mode"),
        Text("Address")
      ], rows: rows),
    );
  }

  List<MizerTableRow> _getRows() {
    var fixtures =
        this.fixtures.sortedByCompare<int>((fixture) => fixture.id, (lhs, rhs) => lhs - rhs);
    List<MizerTableRow> rows = [];
    for (var fixture in fixtures) {
      rows.add(_fixtureRow(fixture, expandedIds.contains(fixture.id)));
      if (expandedIds.contains(fixture.id)) {
        for (var child in fixture.children) {
          rows.add(_subFixtureRow(fixture, child));
        }
      }
    }
    return rows;
  }

  MizerTableRow _fixtureRow(Fixture fixture, bool expanded) {
    var fixtureId = FixtureId(fixture: fixture.id);
    var selected = selectedIds.contains(fixtureId);
    var row = MizerTableRow(
      cells: [
        fixture.children.isEmpty ? Container() : MizerIconButton(
          onClick: () => onExpand(fixture.id),
          icon: expanded ? Icons.arrow_drop_down : Icons.arrow_right,
          label: "Expand",
        ),
        Text(fixtureId.toDisplay()),
        Text(fixture.manufacturer),
        Text(fixture.name),
        Text(fixture.mode),
        Text("${fixture.universe}:${fixture.channel}")
      ],
      onTap: () => onSelect(fixtureId, !selected),
      onDoubleTap: () => onSelectSimilar(fixture),
      selected: selected,
    );
    return row;
  }

  MizerTableRow _subFixtureRow(Fixture fixture, SubFixture child) {
    var fixtureId = FixtureId(subFixture: SubFixtureId(fixtureId: fixture.id, childId: child.id));
    var selected = selectedIds.contains(fixtureId);
    var row = MizerTableRow(
      cells: [
        Text(""),
        Text(fixtureId.toDisplay()),
        Text(""),
        Text(child.name),
        Text(""),
        Text("")
      ],
      onTap: () => onSelect(fixtureId, !selected),
      onDoubleTap: () => onSelectChildren(fixture),
      selected: selected,
    );
    return row;
  }
}

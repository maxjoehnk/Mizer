import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/widgets/controls/icon_button.dart';
import 'package:mizer/widgets/table/table.dart';

class FixturesTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<FixtureId> selectedIds;
  final List<FixtureId> trackedIds;
  final List<int> expandedIds;
  final ProgrammerState? state;
  final Function(FixtureId, bool) onSelect;
  final Function(int) onExpand;
  final Function(Fixture) onSelectSimilar;
  final Function(Fixture) onSelectChildren;

  FixturesTable(
      {required this.fixtures,
      required this.selectedIds,
      required this.trackedIds,
      required this.expandedIds,
      this.state,
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
        1: FixedColumnWidth(64),
      }, columns: const [
        Text(""),
        Text("Id"),
        Text("Name"),
        Text("Intensity"),
        Text("Red"),
        Text("Green"),
        Text("Blue"),
        Text("Pan"),
        Text("Tilt"),
        Text("Gobo"),
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
    var tracked = trackedIds.contains(fixtureId);
    var textStyle = tracked ? TextStyle(color: Colors.deepOrange) : TextStyle();
    var fixtureState = state?.controls.where((channel) => channel.fixtures.contains(fixtureId));
    var row = MizerTableRow(
      cells: [
        fixture.children.isEmpty ? Container() : MizerIconButton(
          onClick: () => onExpand(fixture.id),
          icon: expanded ? Icons.arrow_drop_down : Icons.arrow_right,
          label: "Expand",
        ),
        Text(fixtureId.toDisplay(), style: textStyle),
        Text(fixture.name, style: textStyle),
        Text(_faderState(fixtureState, FixtureControl.INTENSITY), style: textStyle),
        Text(_colorState(fixtureState, (color) => color.red), style: textStyle),
        Text(_colorState(fixtureState, (color) => color.green), style: textStyle),
        Text(_colorState(fixtureState, (color) => color.blue), style: textStyle),
        Text(_faderState(fixtureState, FixtureControl.PAN), style: textStyle),
        Text(_faderState(fixtureState, FixtureControl.TILT), style: textStyle),
        Text(_faderState(fixtureState, FixtureControl.GOBO), style: textStyle),
      ],
      onTap: () => onSelect(fixtureId, !selected),
      onDoubleTap: () => onSelectSimilar(fixture),
      selected: selected,
    );
    return row;
  }

  String _faderState(Iterable<ProgrammerChannel>? fixtureState, FixtureControl control) {
    var value = fixtureState?.firstWhereOrNull((element) => element.control == control)?.fader;
    if (value == null) {
      return "";
    }
    return "${(value * 100).toStringAsFixed(1)}%";
  }

  String _colorState(Iterable<ProgrammerChannel>? fixtureState, double Function(ColorMixerChannel) colorAccessor) {
    var color = fixtureState?.firstWhereOrNull((element) => element.control == FixtureControl.COLOR_MIXER)?.color;
    if (color == null) {
      return "";
    }
    var value = colorAccessor(color);
    return "${(value * 100).toStringAsFixed(1)}%";
  }

  MizerTableRow _subFixtureRow(Fixture fixture, SubFixture subFixture) {
    var fixtureId = FixtureId(subFixture: SubFixtureId(fixtureId: fixture.id, childId: subFixture.id));
    var fixtureState = state?.controls.where((channel) => channel.fixtures.any((f) => f.subFixture == fixtureId.subFixture));
    var selected = selectedIds.contains(fixtureId);
    var row = MizerTableRow(
      cells: [
        Text(""),
        Text(fixtureId.toDisplay()),
        Text(subFixture.name),
        Text(_faderState(fixtureState, FixtureControl.INTENSITY)),
        Text(_colorState(fixtureState, (color) => color.red)),
        Text(_colorState(fixtureState, (color) => color.green)),
        Text(_colorState(fixtureState, (color) => color.blue)),
        Text(_faderState(fixtureState, FixtureControl.PAN)),
        Text(_faderState(fixtureState, FixtureControl.TILT)),
        Text(_faderState(fixtureState, FixtureControl.GOBO)),
      ],
      onTap: () => onSelect(fixtureId, !selected),
      onDoubleTap: () => onSelectChildren(fixture),
      selected: selected,
    );
    return row;
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/views/fixtures/patch_fixture_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

import 'fixture_sheet.dart';

const double SHEET_SIZE = 320;
const double SHEET_PADDING = 16;
const double TAB_STRIP_HEIGHT = 32;
const double SHEET_CONTAINER_HEIGHT = SHEET_SIZE + TAB_STRIP_HEIGHT + SHEET_PADDING;

class FixturesView extends StatefulWidget {
  @override
  State<FixturesView> createState() => _FixturesViewState();
}

class _FixturesViewState extends State<FixturesView> {
  List<int> selectedIds = [];

  @override
  Widget build(BuildContext context) {
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());
    var fixturesApi = context.read<FixturesApi>();
    var programmerApi = context.read<ProgrammerApi>();
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return Column(
        children: [
          Expanded(
            child: Panel(
              label: "Fixtures",
              child: FixtureTable(
                  fixtures: fixtures.fixtures,
                  selectedIds: selectedIds,
                  // TODO: use setSelectedIds instead of manually calling programmerApi
                  onSelect: (id, selected) => setState(() {
                        if (selected) {
                          this.selectedIds.add(id);
                        } else {
                          this.selectedIds.remove(id);
                        }
                        programmerApi.selectFixtures(this.selectedIds);
                      }),
                  onSelectSimilar: (fixture) {
                    _setSelectedIds(fixtures.fixtures
                        .where((f) =>
                    f.manufacturer == fixture.manufacturer && f.name == fixture.name)
                        .map((f) => f.id)
                        .toList());
                  }),
              actions: [
                PanelAction(
                    label: "Add Fixture",
                    onClick: () => _addFixture(context, fixturesApi, fixturesBloc)),
                PanelAction(label: "Select All", onClick: () => _selectAll(fixtures.fixtures)),
                PanelAction(label: "Select Even", onClick: () => _selectEven(fixtures.fixtures)),
                PanelAction(label: "Select Odd", onClick: () => _selectOdd(fixtures.fixtures)),
                PanelAction(label: "Clear", onClick: _clear, disabled: selectedIds.isEmpty)
              ],
            ),
          ),
          SizedBox(
            height: SHEET_CONTAINER_HEIGHT,
            child: FixtureSheet(
                fixtures: fixtures.fixtures.where((f) => selectedIds.contains(f.id)).toList(),
                api: programmerApi),
          ),
        ],
      );
    });
  }

  double get bottomOffset {
    if (selectedIds.isEmpty) {
      return 0;
    }
    return SHEET_CONTAINER_HEIGHT;
  }

  _addFixture(BuildContext context, FixturesApi apiClient, FixturesBloc fixturesBloc) {
    showDialog(context: context, builder: (context) => PatchFixtureDialog(apiClient, fixturesBloc));
  }

  _selectAll(List<Fixture> fixtures) {
    _setSelectedIds(fixtures.map((f) => f.id).toList());
  }

  _selectEven(List<Fixture> fixtures) {
    _setSelectedIds(fixtures.map((f) => f.id).where((id) => id.isEven).toList());
  }

  _selectOdd(List<Fixture> fixtures) {
    _setSelectedIds(fixtures.map((f) => f.id).where((id) => id.isOdd).toList());
  }

  _clear() {
    _setSelectedIds([]);
  }

  _setSelectedIds(List<int> ids) {
    setState(() {
      selectedIds = ids;
      context.read<ProgrammerApi>().selectFixtures(ids);
    });
  }
}

class FixtureTable extends StatelessWidget {
  final List<Fixture> fixtures;
  final List<int> selectedIds;
  final Function(int, bool) onSelect;
  final Function(Fixture) onSelectSimilar;

  const FixtureTable(
      {@required this.fixtures,
      @required this.selectedIds,
      @required this.onSelect,
      this.onSelectSimilar,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MizerTable(
        columns: const [
          Text("Id"),
          Text("Manufacturer"),
          Text("Model"),
          Text("Mode"),
          Text("Address")
        ],
        rows: fixtures
            .sortedByCompare((fixture) => fixture.id, (lhs, rhs) => lhs - rhs)
            .map((fixture) {
          var selected = selectedIds.contains(fixture.id);
          return MizerTableRow(
            cells: [
              Text(fixture.id.toString()),
              Text(fixture.manufacturer),
              Text(fixture.name),
              Text(fixture.mode),
              Text("${fixture.universe}:${fixture.channel}")
            ],
            onTap: () => onSelect(fixture.id, !selected),
            onDoubleTap: () => onSelectSimilar(fixture),
            selected: selected,
          );
        }).toList()),
    );
  }
}

class AddFixturesButton extends StatelessWidget {
  final FixturesApi apiClient;
  final FixturesBloc fixturesBloc;

  AddFixturesButton({this.apiClient, this.fixturesBloc});

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {AddFixture: CallbackAction(onInvoke: (_) => this.openDialog(context))},
      child: FloatingActionButton.extended(
          autofocus: true,
          onPressed: () => this.openDialog(context),
          label: Text("Add Fixture"),
          icon: Icon(Icons.add)),
    );
  }

  openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => PatchFixtureDialog(this.apiClient, this.fixturesBloc));
  }
}

class AddFixture extends Intent {}

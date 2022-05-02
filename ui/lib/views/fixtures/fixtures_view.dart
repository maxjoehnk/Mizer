import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/programmer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/widgets/panel.dart';

import 'fixtures_table.dart';

const double SHEET_SIZE = 320;
const double SHEET_PADDING = 16;
const double TAB_STRIP_HEIGHT = 32;
const double SHEET_CONTAINER_HEIGHT = SHEET_SIZE + TAB_STRIP_HEIGHT + SHEET_PADDING;

class FixturesView extends StatefulWidget {
  @override
  State<FixturesView> createState() => _FixturesViewState();
}

class _FixturesViewState extends State<FixturesView> with SingleTickerProviderStateMixin {
  ProgrammerStatePointer? _pointer;
  Ticker? ticker;
  ProgrammerState state = ProgrammerState();
  List<int> expandedIds = [];

  @override
  void initState() {
    super.initState();
    var programmerApi = context.read<ProgrammerApi>();
    programmerApi.getProgrammerPointer()
      .then((pointer) {
      _pointer = pointer;
        ticker = this.createTicker((elapsed) {
          setState(() {
            state = _pointer!.readState();
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
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());

    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return HotkeyProvider(
        hotkeySelector: (hotkeys) => hotkeys.programmer,
        hotkeyMap: {
          "select_all": () => _selectAll(fixtures.fixtures),
          "clear": () => _clear(),
        },
        child: Panel(
          label: "Fixtures",
          child: FixturesTable(
              fixtures: fixtures.fixtures,
              state: state,
              selectedIds: selectedIds,
              trackedIds: trackedIds,
              expandedIds: expandedIds,
              onSelect: (id, selected) => _setSelectedIds([id]),
              onSelectSimilar: (fixture) {
                _setSelectedIds(fixtures.fixtures
                    .where((f) =>
                        f.manufacturer == fixture.manufacturer && f.model == fixture.model)
                    .map((f) => FixtureId(fixture: f.id))
                    .toList());
              },
              onSelectChildren: (fixture) {
                _setSelectedIds(fixture.children
                    .map((c) => FixtureId(
                        subFixture: SubFixtureId(fixtureId: fixture.id, childId: c.id)))
                    .toList());
              },
              onExpand: (id) => setState(() => this.expandedIds.contains(id)
                  ? this.expandedIds.remove(id)
                  : this.expandedIds.add(id))),
          actions: [
            PanelAction(hotkeyId: "select_all", label: "Select All", onClick: () => _selectAll(fixtures.fixtures)),
            PanelAction(label: "Select Even", onClick: () => _selectEven(fixtures.fixtures)),
            PanelAction(label: "Select Odd", onClick: () => _selectOdd(fixtures.fixtures)),
            PanelAction(hotkeyId: "clear", label: "Clear", onClick: _clear, disabled: trackedIds.isEmpty && selectedIds.isEmpty),
          ],
        ),
      );
    });
  }

  List<FixtureId> get trackedIds {
    return state.fixtures;
  }

  List<FixtureId> get selectedIds {
    return state.activeFixtures;
  }

  List<FixtureInstance> getSelectedInstances(List<FixtureId> selectedIds, List<Fixture> fixtures) {
    return selectedIds
        .map((id) => fixtures.getFixture(id))
        .where((element) => element != null)
        .map((fixture) => fixture!)
        .toList();
  }

  _selectAll(List<Fixture> fixtures) {
    _setSelectedIds(fixtures.map((f) => FixtureId(fixture: f.id)).toList());
  }

  _selectEven(List<Fixture> fixtures) {
    _setSelectedIds(fixtures
        .map((f) => f.id)
        .where((id) => id.isEven)
        .map((id) => FixtureId(fixture: id))
        .toList());
  }

  _selectOdd(List<Fixture> fixtures) {
    _setSelectedIds(fixtures
        .map((f) => f.id)
        .where((id) => id.isOdd)
        .map((id) => FixtureId(fixture: id))
        .toList());
  }

  _clear() {
    context.read<ProgrammerApi>().clear();
  }

  _setSelectedIds(List<FixtureId> ids) {
    context.read<ProgrammerApi>().selectFixtures(ids);
  }
}

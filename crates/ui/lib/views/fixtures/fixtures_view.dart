import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/mixins/fixture_values_mixin.dart';
import 'package:mizer/mixins/programmer_mixin.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
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

class _FixturesViewState extends State<FixturesView>
    with TickerProviderStateMixin, ProgrammerStateMixin, FixtureValuesMixin {
  List<int> expandedIds = [];
  String? searchQuery;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FixturesBloc fixturesBloc = context.read();
      fixturesBloc.add(FetchFixtures());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return HotkeyConfiguration(
        hotkeySelector: (hotkeys) => hotkeys.programmer,
        hotkeyMap: {
          "select_all": () => _selectAll(fixtures.fixtures),
          "clear": () => _clear(),
        },
        child: Panel(
          label: "Fixtures".i18n,
          child: FixturesTable(
              fixtures: _getFixtures(fixtures),
              state: programmerState,
              fixtureValues: fixtureValues,
              selectedIds: selectedIds,
              trackedIds: trackedIds,
              expandedIds: expandedIds,
              onSelect: (id, selected) => _setSelectedIds([id]),
              onSelectSimilar: (fixture) {
                _setSelectedIds(fixtures.fixtures
                    .where(
                        (f) => f.manufacturer == fixture.manufacturer && f.model == fixture.model)
                    .map((f) => FixtureId(fixture: f.id))
                    .toList());
              },
              onSelectChildren: (fixture) {
                _setSelectedIds(fixture.children
                    .map((c) =>
                        FixtureId(subFixture: SubFixtureId(fixtureId: fixture.id, childId: c.id)))
                    .toList());
              },
              onExpand: (id) => setState(() => this.expandedIds.contains(id)
                  ? this.expandedIds.remove(id)
                  : this.expandedIds.add(id))),
          actions: [
            PanelActionModel(
                hotkeyId: "select_all",
                label: "Select All".i18n,
                onClick: () => _selectAll(fixtures.fixtures)),
            PanelActionModel(label: "Select Even", onClick: () => _selectEven(fixtures.fixtures)),
            PanelActionModel(label: "Select Odd", onClick: () => _selectOdd(fixtures.fixtures)),
            PanelActionModel(
                hotkeyId: "clear",
                label: "Clear".i18n,
                onClick: _clear,
                disabled: trackedIds.isEmpty && selectedIds.isEmpty,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForClear(context))
                ])),
          ],
          onSearch: (query) => setState(() => this.searchQuery = query),
        ),
      );
    });
  }

  List<Fixture> _getFixtures(Fixtures fixtures) {
    return fixtures.fixtures
        .search([(f) => f.name, (f) => f.manufacturer, (f) => f.model], searchQuery).toList();
  }

  List<FixtureId> get trackedIds {
    return programmerState.fixtures;
  }

  List<FixtureId> get selectedIds {
    return programmerState.activeFixtures;
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

  Future<void> _addMidiMappingForClear(BuildContext context) async {
    var request = MappingRequest(
      programmerClear: ProgrammerClearAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Clear", request);
  }
}

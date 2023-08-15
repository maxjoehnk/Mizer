import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/widgets/panel.dart';

import 'dialogs/assign_fixtures_to_group_dialog.dart';
import 'dialogs/delete_fixture_dialog.dart';
import 'dialogs/patch_fixture_dialog.dart';
import 'fixture_table.dart';

class FixturePatchView extends StatefulWidget {
  @override
  State<FixturePatchView> createState() => _FixturePatchViewState();
}

class _FixturePatchViewState extends State<FixturePatchView> {
  List<int> selectedIds = [];
  String? searchQuery;

  @override
  Widget build(BuildContext context) {
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());
    var fixturesApi = context.read<FixturesApi>();
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return HotkeyConfiguration(
        hotkeySelector: (hotkeys) => hotkeys.patch,
        hotkeyMap: {
          "add_fixture": () => _addFixture(context, fixturesApi, fixturesBloc),
          "select_all": () => _selectAll(fixtures.fixtures),
          "clear": () => _clear(),
          "delete": () => _deleteFixture(context, fixturesBloc),
          "assign_group": () => _assignGroup(context, fixturesBloc),
          "export_patch": () => _exportPatch(context),
        },
        child: Column(
          children: [
            Expanded(
              child: Panel(
                label: "Fixtures",
                child: FixtureTable(
                  fixtures: fixtures.fixtures.search(
                      [(f) => f.name, (f) => f.manufacturer, (f) => f.mode], searchQuery).toList(),
                  selectedIds: selectedIds,
                  onSelect: (id, selected) => setState(() {
                    if (selected) {
                      this.selectedIds.add(id);
                    } else {
                      this.selectedIds.remove(id);
                    }
                  }),
                  onSelectSimilar: (fixture) => setState(() => selectedIds = fixtures.fixtures
                      .where(
                          (f) => f.manufacturer == fixture.manufacturer && f.model == fixture.model)
                      .map((f) => f.id)
                      .toList()),
                  onUpdateFixture: (fixtureId, updateRequest) =>
                      fixturesBloc.add(UpdateFixture(fixtureId, updateRequest)),
                ),
                actions: [
                  PanelActionModel(
                      label: "Add Fixture",
                      hotkeyId: "add_fixture",
                      onClick: () => _addFixture(context, fixturesApi, fixturesBloc)),
                  PanelActionModel(
                      label: "Clear",
                      hotkeyId: "clear",
                      onClick: _clear,
                      disabled: selectedIds.isEmpty),
                  PanelActionModel(
                      label: "Delete",
                      hotkeyId: "delete",
                      onClick: () => _deleteFixture(context, fixturesBloc),
                      disabled: selectedIds.isEmpty),
                  PanelActionModel(
                      label: "Assign Group",
                      hotkeyId: "assign_group",
                      onClick: () => _assignGroup(context, fixturesBloc)),
                  PanelActionModel(
                    label: "Export Patch",
                    hotkeyId: "export_patch",
                    onClick: () => _exportPatch(context),
                  )
                ],
                onSearch: (query) => setState(() => searchQuery = query),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Fixture> getSelectedInstances(List<Fixture> fixtures) {
    return selectedIds.map((id) => fixtures.firstWhere((f) => f.id == id)).toList();
  }

  _addFixture(BuildContext context, FixturesApi apiClient, FixturesBloc fixturesBloc) {
    showDialog(context: context, builder: (context) => PatchFixtureDialog(apiClient, fixturesBloc));
  }

  _selectAll(List<Fixture> fixtures) {
    _setSelectedIds(fixtures.map((f) => f.id).toList());
  }

  _clear() {
    _setSelectedIds([]);
  }

  _deleteFixture(BuildContext context, FixturesBloc fixturesBloc) async {
    if (await showDialog(context: context, builder: (context) => DeleteFixtureDialog())) {
      fixturesBloc.add(DeleteFixtures(selectedIds));
      _setSelectedIds([]);
    }
  }

  _setSelectedIds(List<int> ids) {
    setState(() => selectedIds = ids);
  }

  _assignGroup(BuildContext context, FixturesBloc fixturesBloc) async {
    var programmerApi = context.read<ProgrammerApi>();
    var presetsBloc = context.read<PresetsBloc>();
    Group? group = await showDialog(
        context: context,
        builder: (context) => AssignFixturesToGroupDialog(presetsBloc, programmerApi));
    if (group == null) {
      return;
    }
    await programmerApi.assignFixturesToGroup(
        selectedIds.map((id) => FixtureId(fixture: id)).toList(), group);
  }

  _exportPatch(BuildContext context) async {
    final typeGroup = XTypeGroup(label: 'CSV'.i18n, extensions: ['csv']);
    final location = await getSaveLocation(acceptedTypeGroups: [typeGroup]);
    if (location == null) {
      return;
    }

    var fixturesApi = context.read<FixturesApi>();
    await fixturesApi.exportPatch(location.path);
  }
}

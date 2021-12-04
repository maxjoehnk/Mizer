import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/widgets/panel.dart';

import 'fixture_table.dart';
import 'dialogs/patch_fixture_dialog.dart';
import 'dialogs/delete_fixture_dialog.dart';

class FixturePatchView extends StatefulWidget {
  @override
  State<FixturePatchView> createState() => _FixturePatchViewState();
}

class _FixturePatchViewState extends State<FixturePatchView> {
  List<int> selectedIds = [];

  @override
  Widget build(BuildContext context) {
    FixturesBloc fixturesBloc = context.read();
    fixturesBloc.add(FetchFixtures());
    var fixturesApi = context.read<FixturesApi>();
    return BlocBuilder<FixturesBloc, Fixtures>(builder: (context, fixtures) {
      return HotkeyProvider(
        hotkeySelector: (hotkeys) => hotkeys.patch,
        hotkeyMap: {
          "add_fixture": () => _addFixture(context, fixturesApi, fixturesBloc),
          "select_all": () => _selectAll(fixtures.fixtures),
          "clear": () => _clear(),
        },
        child: Column(
          children: [
            Expanded(
              child: Panel(
                label: "Fixtures",
                child: FixtureTable(
                    fixtures: fixtures.fixtures,
                    selectedIds: selectedIds,
                    onSelect: (id, selected) => setState(() {
                          if (selected) {
                            this.selectedIds.add(id);
                          } else {
                            this.selectedIds.remove(id);
                          }
                        }),
                ),
                actions: [
                  PanelAction(
                      label: "Add Fixture",
                      onClick: () => _addFixture(context, fixturesApi, fixturesBloc)),
                  PanelAction(label: "Clear", onClick: _clear, disabled: selectedIds.isEmpty),
                  PanelAction(label: "Delete", onClick: () => _deleteFixture(context, fixturesBloc), disabled: selectedIds.isEmpty)
                ],
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
}

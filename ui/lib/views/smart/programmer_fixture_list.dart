import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/extensions/fixture_id_extensions.dart';
import 'package:mizer/extensions/programmer_channel_extensions.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/table/table.dart';

import 'smart_view.dart';

class ProgrammerFixtureList extends StatelessWidget {
  final ProgrammerState programmerState;
  final List<FixtureEntry> fixtures;
  final ProgrammerApi api;

  const ProgrammerFixtureList(
      {required this.programmerState, required this.fixtures, required this.api, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var channels =
    programmerState.controls.map((c) => c.control).toSet().sorted((a, b) => a.value - b.value);
    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.programmer,
      hotkeyMap: {
        "clear": () => _clear(),
        "highlight": () => _highlight(),
      },
      child: Panel(
        label: "Fixtures",
        actions: [
          PanelAction(
              label: "Highlight",
              hotkeyId: "highlight",
              activated: programmerState.highlight,
              onClick: _highlight),
          PanelAction(
              label: "Clear",
              hotkeyId: "clear",
              disabled: programmerState.fixtures.isEmpty && programmerState.activeFixtures.isEmpty,
              onClick: _clear),
        ],
        child: SingleChildScrollView(
          child: MizerTable(
            columns: [Text("ID"), Text("Name"), ...channels.map((c) => Text(NAMES[c]!))],
            rows: fixtures
                .map((f) => MizerTableRow(cells: [
              Text(f.id.toDisplay()),
              Text(f.name),
              ...channels
                  .map((control) => programmerState.controls.firstWhereOrNull(
                      (c) => control == c.control && c.fixtures.contains(f.id)))
                  .map((control) =>
              control == null ? Text("") : Text(control.toDisplayValue()))
            ], selected: programmerState.activeFixtures.contains(f.id)))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _highlight() {
    api.highlight(!programmerState.highlight);
  }

  void _clear() {
    api.clear();
  }
}

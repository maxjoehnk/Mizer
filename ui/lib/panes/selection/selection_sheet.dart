import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/views/patch/dialogs/assign_fixtures_to_group_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class SelectionSheet extends StatefulWidget {
  final ProgrammerApi api;
  final List<FixtureInstance> fixtures;
  final bool isEmpty;

  const SelectionSheet({required this.fixtures, required this.api, required this.isEmpty, Key? key})
      : super(key: key);

  @override
  State<SelectionSheet> createState() => _SelectionSheetState();
}

class _SelectionSheetState extends State<SelectionSheet> with SingleTickerProviderStateMixin {
  FixturesRefPointer? _fixturesPointer;

  @override
  void initState() {
    super.initState();
    PlansApi plansApi = context.read();
    plansApi.getFixturesPointer().then((pointer) {
      setState(() {
        _fixturesPointer = pointer;
      });
    });
  }

  @override
  void dispose() {
    _fixturesPointer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fixturesPointer == null) {
      return Container();
    }
    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.programmer,
      hotkeyMap: {
        "clear": () => _clear(),
        "assign_group": () => _assignGroup(context),
      },
      child: Panel(
          label: "Selection",
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: widget.fixtures
                    .map((f) => FixtureSelectionItem(
                          fixture: f,
                          ref: _fixturesPointer!,
                        ))
                    .toList()),
          ),
          actions: [
            PanelAction(
                hotkeyId: "clear",
                label: "Clear",
                onClick: () => _clear(),
                disabled: widget.isEmpty,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForClear(context))
                ])),
            PanelAction(label: "Assign Group", hotkeyId: "assign_group", disabled: widget.isEmpty, onClick: () => _assignGroup(context)),
          ]),
    );
  }

  void _clear() {
    widget.api.clear();
  }

  Future<void> _addMidiMappingForClear(BuildContext context) async {
    var request = MappingRequest(
      programmerClear: ProgrammerClearAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Clear", request);
  }

  _assignGroup(BuildContext context) async {
    var programmerApi = context.read<ProgrammerApi>();
    var presetsBloc = context.read<PresetsBloc>();
    Group? group = await showDialog(context: context, builder: (context) => AssignFixturesToGroupDialog(presetsBloc, programmerApi));
    if (group == null) {
      return;
    }
    await programmerApi.assignFixturesToGroup(widget.fixtures.map((e) => e.id).toList(), group);
  }
}

class FixtureSelectionItem extends StatefulWidget {
  final FixturesRefPointer ref;
  final FixtureInstance fixture;

  const FixtureSelectionItem({required this.ref, required this.fixture, Key? key})
      : super(key: key);

  @override
  State<FixtureSelectionItem> createState() => _FixtureSelectionItemState();
}

class _FixtureSelectionItemState extends State<FixtureSelectionItem>
    with SingleTickerProviderStateMixin {
  Ticker? ticker;
  FixtureState state = FixtureState();

  @override
  void initState() {
    super.initState();
    ticker = this.createTicker((elapsed) {
      setState(() {
        state = widget.ref.readState(widget.fixture.id);
      });
    });
    ticker!.start();
  }

  @override
  void dispose() {
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.fixture.name ?? "",
      child: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(2),
          child: Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(
                    color: Colors.grey.shade800,
                    width: 4,
                    style: BorderStyle.solid,
                  ),
                ),
                color: state.getColor(),
              ),
              child:
                  Align(alignment: Alignment.topLeft, child: Text(widget.fixture.id.toDisplay())))),
    );
  }
}

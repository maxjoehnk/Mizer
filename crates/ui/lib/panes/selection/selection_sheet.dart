import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/platform/platform.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/number_field.dart';
import 'package:mizer/views/patch/dialogs/assign_fixtures_to_group_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class SelectionSheet extends StatefulWidget {
  final ProgrammerApi api;
  final List<FixtureInstance> fixtures;
  final bool isEmpty;
  final ProgrammerState state;

  const SelectionSheet(
      {required this.fixtures,
      required this.api,
      required this.isEmpty,
      required this.state,
      Key? key})
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
        "next": () => _next(),
        "prev": () => _prev(),
        "set": () => _set(),
        "shuffle": () => _shuffle(),
      },
      child: Panel(
          label: "Selection",
          child: Padding(
            padding: const EdgeInsets.all(PANEL_GAP_SIZE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: PANEL_GAP_SIZE,
              children: [
                SizedBox(
                  height: GRID_2_SIZE,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: PANEL_GAP_SIZE,
                        children: widget.fixtures
                            .map((f) => FixtureSelectionItem(
                                  fixture: f,
                                  ref: _fixturesPointer!,
                                ))
                            .toList()),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: INPUT_FIELD_HEIGHT,
                  child: Row(spacing: PANEL_GAP_SIZE, children: [
                    Expanded(
                      child: NumberField(
                          label: "Block Size",
                          value: widget.state.blockSize,
                          min: 0,
                          maxHint: 10,
                          onUpdate: (v) {
                            var api = context.read<ProgrammerApi>();
                            api.updateBlockSize(v.toInt());
                          }),
                    ),
                    Expanded(
                      child: NumberField(
                          label: "Groups",
                          value: widget.state.groups,
                          min: 0,
                          maxHint: 10,
                          onUpdate: (v) {
                            var api = context.read<ProgrammerApi>();
                            api.updateGroups(v.toInt());
                          }),
                    ),
                    Expanded(
                      child: NumberField(
                          label: "Wings",
                          value: widget.state.wings,
                          min: 0,
                          maxHint: 10,
                          onUpdate: (v) {
                            var api = context.read<ProgrammerApi>();
                            api.updateWings(v.toInt());
                          }),
                    ),
                  ]),
                )
              ],
            ),
          ),
          actions: [
            PanelActionModel(
                hotkeyId: "clear",
                label: "Clear",
                onClick: () => _clear(),
                disabled: widget.isEmpty,
                menu: Menu(items: [
                  MenuItem(
                      label: "Add Midi Mapping", action: () => _addMidiMappingForClear(context))
                ])),
            PanelActionModel(
                label: "Assign Group",
                hotkeyId: "assign_group",
                disabled: widget.isEmpty,
                onClick: () => _assignGroup(context)),
            PanelActionModel(
                label: "Shuffle",
                hotkeyId: "shuffle",
                disabled: widget.isEmpty,
                onClick: () => _shuffle()),
            PanelActionModel(
                label: "Set", hotkeyId: "set", disabled: widget.isEmpty, onClick: () => _set()),
            PanelActionModel(
                label: "Prev", hotkeyId: "prev", disabled: widget.isEmpty, onClick: () => _prev()),
            PanelActionModel(
                label: "Next", hotkeyId: "next", disabled: widget.isEmpty, onClick: () => _next()),
          ]),
    );
  }

  void _clear() {
    widget.api.clear();
  }

  void _next() {
    widget.api.next();
  }

  void _prev() {
    widget.api.prev();
  }

  void _set() {
    widget.api.set();
  }

  void _shuffle() {
    widget.api.shuffle();
  }

  Future<void> _addMidiMappingForClear(BuildContext context) async {
    var request = MappingRequest(
      programmerClear: ProgrammerClearAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Clear", request);
  }

  _assignGroup(BuildContext context) async {
    var result = await AssignFixturesToGroupDialog.open(context);
    if (result == null) {
      return;
    }
    var programmerApi = context.read<ProgrammerApi>();
    await programmerApi.assignFixtureSelectionToGroup(result.group, result.mode);
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
    return Container(
        width: GRID_2_SIZE,
        height: GRID_2_SIZE,
        child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                side: BorderSide(
                  color: Grey700,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              color: state.getColor(),
            ),
            child:
                Align(alignment: Alignment.topLeft, child: Text(widget.fixture.id.toDisplay()))));
  }
}

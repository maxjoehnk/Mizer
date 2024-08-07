import 'package:flutter/material.dart' show showDialog;
import 'package:flutter/widgets.dart' hide MenuItem;
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/panes/programmer/dialogs/select_preset_type_dialog.dart';
import 'package:mizer/panes/programmer/dialogs/select_store_target_dialog.dart';
import 'package:mizer/platform/contracts/menu.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/protos/mappings.pb.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/state/presets_bloc.dart';
import 'package:mizer/views/mappings/midi_mapping.dart';
import 'package:mizer/views/patch/dialogs/assign_fixtures_to_group_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/switch.dart';
import 'package:mizer/widgets/tabs.dart';
import 'package:provider/provider.dart';

import 'dialogs/select_cue_dialog.dart';
import 'dialogs/select_preset_dialog.dart';
import 'dialogs/select_sequence_dialog.dart';
import 'dialogs/store_mode_dialog.dart';
import 'sheets/beam_sheet.dart';
import 'sheets/channel_sheet.dart';
import 'sheets/color_sheet.dart';
import 'sheets/dimmer_sheet.dart';
import 'sheets/effects_sheet.dart';
import 'sheets/gobo_sheet.dart';
import 'sheets/position_sheet.dart';

class ProgrammerSheet extends StatefulWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;
  final List<EffectProgrammerState> effects;
  final bool isEmpty;
  final ProgrammerApi api;
  final bool highlight;
  final bool offline;

  const ProgrammerSheet(
      {required this.fixtures,
      required this.channels,
      required this.effects,
      required this.api,
      required this.isEmpty,
      required this.highlight,
      required this.offline,
      Key? key})
      : super(key: key);

  @override
  State<ProgrammerSheet> createState() => _ProgrammerSheetState();
}

class _ProgrammerSheetState extends State<ProgrammerSheet> {
  @override
  Widget build(BuildContext context) {
    return HotkeyConfiguration(
      hotkeySelector: (hotkeys) => hotkeys.programmer,
      hotkeyMap: {
        "store": () => _store(),
        "highlight": () => _highlight(),
        "clear": () => _clear(),
      },
      child: Panel.tabs(
        label: "Programmer",
        tabs: [
          Tab(
              label: "Dimmer",
              child: DimmerSheet(fixtures: widget.fixtures, channels: widget.channels)),
          Tab(
              label: "Position",
              child: PositionSheet(fixtures: widget.fixtures, channels: widget.channels)),
          Tab(
              label: "Gobo",
              child: GoboSheet(fixtures: widget.fixtures, channels: widget.channels)),
          Tab(
              label: "Color",
              child: ColorSheet(fixtures: widget.fixtures, channels: widget.channels)),
          Tab(
              label: "Beam",
              child: BeamSheet(fixtures: widget.fixtures, channels: widget.channels)),
          Tab(
              label: "Channels",
              child: ChannelSheet(fixtures: widget.fixtures, channels: widget.channels)),
          Tab(
            label: "Effects",
            child: EffectsSheet(effects: widget.effects),
          )
        ],
        actions: [
          PanelActionModel(
              hotkeyId: "highlight",
              label: "Highlight",
              activated: widget.highlight,
              onClick: _highlight,
              menu: Menu(items: [
                MenuItem(
                    label: "Add Midi Mapping", action: () => _addMidiMappingForHighlight(context))
              ])),
          PanelActionModel(
              hotkeyId: "store", label: "Store", onClick: () => _store(), disabled: widget.isEmpty),
          PanelActionModel(
              hotkeyId: "clear",
              label: "Clear",
              onClick: () => _clear(),
              disabled: widget.isEmpty,
              menu: Menu(items: [
                MenuItem(label: "Add Midi Mapping", action: () => _addMidiMappingForClear(context))
              ])),
        ],
        padding: false,
        trailingHeader: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            child: MizerSwitch(
                onText: "Live",
                offText: "Offline",
                value: !widget.offline,
                onChanged: (bool value) => context.read<ProgrammerApi>().setOffline(!value)),
          ),
        ],
      ),
    );
  }

  void _highlight() {
    widget.api.highlight(!widget.highlight);
  }

  void _clear() {
    widget.api.clear();
  }

  _store() async {
    var storeTarget = await selectStoreTarget(context);
    if (storeTarget == null) {
      return;
    }

    if (storeTarget == StoreTarget.Sequence) {
      await _storeToSequence();
    } else if (storeTarget == StoreTarget.Group) {
      await _storeToGroup();
    } else if (storeTarget == StoreTarget.Preset) {
      await _storeToPreset();
    }
  }

  _storeToGroup() async {
    var programmerApi = context.read<ProgrammerApi>();
    var presetsBloc = context.read<PresetsBloc>();
    Group? group = await showDialog(
        context: context,
        builder: (context) => AssignFixturesToGroupDialog(presetsBloc, programmerApi));
    if (group == null) {
      return;
    }
    await programmerApi.assignFixtureSelectionToGroup(group);
  }

  _storeToPreset() async {
    var presetType = await selectPresetType(context);
    if (presetType == null) {
      return;
    }
    var presetsBloc = context.read<PresetsBloc>();
    dynamic result = await showDialog(
        context: context, builder: (context) => SelectPresetDialog(presetType, presetsBloc.state));
    if (result == null) {
      return;
    }
    if (result is PresetId) {
      presetsBloc.add(StorePresets.existing(result));
    } else if (result is PresetType) {
      presetsBloc.add(StorePresets.newPreset(result, null));
    }
  }

  _storeToSequence() async {
    var sequencerApi = context.read<SequencerApi>();
    Sequence? sequence = await showDialog(
        context: context, builder: (context) => SelectSequenceDialog(api: sequencerApi));
    if (sequence == null) {
      return;
    }
    var storeMode = await _getStoreMode(sequence);
    if (storeMode == null) {
      return;
    }
    int? cueId;
    if (storeMode != StoreRequest_Mode.ADD_CUE && sequence.cues.isNotEmpty) {
      cueId = await _getCue(sequence, storeMode);

      if (cueId == null) {
        return;
      }
    }

    widget.api.store(sequence.id, storeMode, cueId: cueId);
  }

  _getStoreMode(Sequence sequence) async {
    if (sequence.cues.isEmpty) {
      return StoreRequest_Mode.OVERWRITE;
    }

    return await showDialog(context: context, builder: (context) => StoreModeDialog());
  }

  Future<int?> _getCue(Sequence sequence, StoreRequest_Mode storeMode) async {
    if (sequence.cues.length == 1) {
      return sequence.cues.first.id;
    }
    Cue? cue = await showDialog(context: context, builder: (context) => SelectCueDialog(sequence));

    return cue?.id;
  }

  Future<void> _addMidiMappingForHighlight(BuildContext context) async {
    var request = MappingRequest(
      programmerHighlight: ProgrammerHighlightAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Highlight", request);
  }

  Future<void> _addMidiMappingForClear(BuildContext context) async {
    var request = MappingRequest(
      programmerClear: ProgrammerClearAction(),
    );
    addMidiMapping(context, "Add MIDI Mapping for Programmer Clear", request);
  }
}

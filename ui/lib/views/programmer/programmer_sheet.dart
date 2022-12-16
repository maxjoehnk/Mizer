import 'package:flutter/material.dart' show showDialog;
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/settings/hotkeys/hotkey_configuration.dart';
import 'package:mizer/views/programmer/dialogs/select_sequence_dialog.dart';
import 'package:mizer/views/programmer/dialogs/store_mode_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';
import 'package:provider/provider.dart';

import 'dialogs/select_cue_dialog.dart';
import 'sheets/beam_sheet.dart';
import 'sheets/channel_sheet.dart';
import 'sheets/color_sheet.dart';
import 'sheets/dimmer_sheet.dart';
import 'sheets/gobo_sheet.dart';
import 'sheets/position_sheet.dart';

class ProgrammerSheet extends StatefulWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;
  final bool isEmpty;
  final ProgrammerApi api;
  final bool highlight;

  const ProgrammerSheet({required this.fixtures, required this.channels, required this.api, required this.isEmpty, required this.highlight, Key? key}) : super(key: key);

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
            Tab(label: "Dimmer", child: DimmerSheet(fixtures: widget.fixtures, channels: widget.channels)),
            Tab(label: "Position", child: PositionSheet(fixtures: widget.fixtures, channels: widget.channels)),
            Tab(label: "Gobo", child: GoboSheet(fixtures: widget.fixtures, channels: widget.channels)),
            Tab(label: "Color", child: ColorSheet(fixtures: widget.fixtures, channels: widget.channels)),
            Tab(label: "Beam", child: BeamSheet(fixtures: widget.fixtures, channels: widget.channels)),
            Tab(label: "Channels", child: ChannelSheet(fixtures: widget.fixtures, channels: widget.channels)),
          ],
          actions: [
            PanelAction(
                hotkeyId: "highlight",
                label: "Highlight",
                activated: widget.highlight,
                onClick: _highlight),
            PanelAction(hotkeyId: "store", label: "Store", onClick: () => _store(), disabled: widget.isEmpty),
            PanelAction(hotkeyId: "clear", label: "Clear", onClick: () => _clear(), disabled: widget.isEmpty),
          ]),
    );
  }

  void _highlight() {
    widget.api.highlight(!widget.highlight);
  }

  void _clear() {
    widget.api.clear();
  }

  _store() async {
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
    if (storeMode != StoreRequest_Mode.AddCue && sequence.cues.isNotEmpty) {
      cueId = await _getCue(sequence, storeMode);

      if (cueId == null) {
        return;
      }
    }

    widget.api.store(sequence.id, storeMode, cueId: cueId);
  }

  _getStoreMode(Sequence sequence) async {
    if (sequence.cues.isEmpty) {
      return StoreRequest_Mode.Overwrite;
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
}

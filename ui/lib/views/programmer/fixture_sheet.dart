import 'package:flutter/material.dart' show showDialog;
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/views/programmer/dialogs/select_sequence_dialog.dart';
import 'package:mizer/views/programmer/dialogs/store_mode_dialog.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';
import 'package:provider/provider.dart';

import 'sheets/beam_sheet.dart';
import 'sheets/channel_sheet.dart';
import 'sheets/color_sheet.dart';
import 'sheets/dimmer_sheet.dart';
import 'sheets/gobo_sheet.dart';
import 'sheets/position_sheet.dart';

class FixtureSheet extends StatefulWidget {
  final List<FixtureInstance> fixtures;
  final List<ProgrammerChannel> channels;
  final ProgrammerApi api;
  final bool highlight;

  const FixtureSheet({required this.fixtures, required this.channels, required this.api, required this.highlight, Key? key}) : super(key: key);

  @override
  State<FixtureSheet> createState() => _FixtureSheetState();
}

class _FixtureSheetState extends State<FixtureSheet> {
  @override
  Widget build(BuildContext context) {
    return HotkeyProvider(
      hotkeySelector: (hotkeys) => hotkeys.programmer,
      hotkeyMap: {
        "clear": () => widget.api.clear(),
        "store": () => _store(),
        "highlight": () => _highlight(),
      },
      child: Panel.tabs(
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
                onClick: _highlight,
                disabled: widget.fixtures.isEmpty),
            PanelAction(hotkeyId: "store", label: "Store", onClick: () => _store(), disabled: widget.fixtures.isEmpty),
            PanelAction(
              hotkeyId: "clear",
                label: "Clear", onClick: () => widget.api.clear(), disabled: widget.fixtures.isEmpty),
          ]),
    );
  }

  void _highlight() {
    widget.api.highlight(!widget.highlight);
  }

  _store() async {
    var sequencerApi = context.read<SequencerApi>();
    var sequence = await showDialog(
        context: context, builder: (context) => SelectSequenceDialog(api: sequencerApi));
    if (sequence == null) {
      return;
    }
    var storeMode = await _getStoreMode(sequence);
    if (storeMode == null) {
      return;
    }

    widget.api.store(sequence.id, storeMode);
  }

  _getStoreMode(Sequence sequence) async {
    if (sequence.cues.isEmpty) {
      return StoreRequest_Mode.Overwrite;
    }

    return await showDialog(context: context, builder: (context) => StoreModeDialog());
  }
}

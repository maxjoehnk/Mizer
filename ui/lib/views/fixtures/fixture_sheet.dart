import 'package:flutter/material.dart' show showDialog;
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/fixtures.extensions.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/views/fixtures/dialogs/select_sequence_dialog.dart';
import 'package:mizer/views/fixtures/dialogs/store_mode_dialog.dart';
import 'package:mizer/views/fixtures/position_sheet.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart';
import 'package:provider/provider.dart';

import 'beam_sheet.dart';
import 'channel_sheet.dart';
import 'color_sheet.dart';
import 'dimmer_sheet.dart';
import 'gobo_sheet.dart';

class FixtureSheet extends StatefulWidget {
  final List<FixtureInstance> fixtures;
  final ProgrammerApi api;

  const FixtureSheet({required this.fixtures, required this.api, Key? key}) : super(key: key);

  @override
  State<FixtureSheet> createState() => _FixtureSheetState();
}

class _FixtureSheetState extends State<FixtureSheet> {
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return HotkeyProvider(
      hotkeySelector: (hotkeys) => hotkeys.fixtures,
      hotkeyMap: {
        "clear": () => widget.api.clear(),
        "store": () => _store(),
        "highlight": () => _highlight(),
      },
      child: Panel(
          child: Tabs(
            children: [
              Tab(label: "Dimmer", child: DimmerSheet(fixtures: widget.fixtures)),
              Tab(label: "Position", child: PositionSheet(fixtures: widget.fixtures)),
              Tab(label: "Gobo", child: GoboSheet(fixtures: widget.fixtures)),
              Tab(label: "Color", child: ColorSheet(fixtures: widget.fixtures)),
              Tab(label: "Beam", child: BeamSheet(fixtures: widget.fixtures)),
              Tab(label: "Channels", child: ChannelSheet(fixtures: widget.fixtures)),
            ],
          ),
          actions: [
            PanelAction(
                label: "Highlight",
                activated: highlight,
                onClick: _highlight,
                disabled: widget.fixtures.isEmpty),
            PanelAction(label: "Store", onClick: () => _store(), disabled: widget.fixtures.isEmpty),
            PanelAction(
                label: "Clear", onClick: () => widget.api.clear(), disabled: widget.fixtures.isEmpty),
          ]),
    );
  }

  void _highlight() {
    setState(() {
      highlight = !highlight;
      widget.api.highlight(highlight);
    });
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

import 'package:flutter/material.dart' show showDialog;
import 'package:flutter/widgets.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
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
  final List<Fixture> fixtures;
  final ProgrammerApi api;

  const FixtureSheet({this.fixtures, this.api, Key key}) : super(key: key);

  @override
  State<FixtureSheet> createState() => _FixtureSheetState();
}

class _FixtureSheetState extends State<FixtureSheet> {
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return Panel(
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
              onClick: () {
                setState(() {
                  highlight = !highlight;
                  widget.api.highlight(highlight);
                });
              },
              disabled: widget.fixtures.isEmpty),
          PanelAction(label: "Store", onClick: () => _store(), disabled: widget.fixtures.isEmpty),
          PanelAction(
              label: "Clear", onClick: () => widget.api.clear(), disabled: widget.fixtures.isEmpty),
        ]);
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

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/views/sequencer/sequencer_settings.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:mizer/widgets/tabs.dart' as tabs;

import 'cue_list.dart';
import 'sequence_list.dart';
import 'track_sheet.dart';

class SequencerView extends StatefulWidget {
  const SequencerView({Key? key}) : super(key: key);

  @override
  State<SequencerView> createState() => _SequencerViewState();
}

class _SequencerViewState extends State<SequencerView> with SingleTickerProviderStateMixin {
  SequencerPointer? _pointer;
  Map<int, SequenceState> sequenceStates = {};
  Ticker? ticker;

  @override
  void initState() {
    super.initState();
    var sequencerApi = context.read<SequencerApi>();
    sequencerApi.getSequencerPointer()
        .then((pointer) => setState(() {
          _pointer = pointer;
          ticker = this.createTicker((elapsed) {
            setState(() {
              sequenceStates = _pointer!.readState();
            });
          });
          ticker!.start();
        }));
  }

  @override
  void dispose() {
    _pointer?.dispose();
    ticker?.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<FixturesBloc>().add(FetchFixtures());
    context.read<SequencerBloc>().add(FetchSequences());
    return HotkeyProvider(
      hotkeySelector: (hotkeys) => hotkeys.sequencer,
      hotkeyMap: {},
      child: BlocBuilder<SequencerBloc, SequencerState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Panel(
                  label: "Sequences",
                  child: SequenceList(selectSequence: _selectSequence, selectedSequence: state.selectedSequence, sequenceStates: sequenceStates),
                  actions: [
                    PanelAction(label: "Go+", onClick: () => _sequenceGo(state.selectedSequenceId!)),
                    PanelAction(label: "Stop", onClick: () => _sequenceStop(state.selectedSequenceId!)),
                    PanelAction(hotkeyId: "delete", label: "Delete", onClick: () => _deleteSequence(state.selectedSequenceId!), disabled: state.selectedSequenceId == null),
                  ],
                ),
              ),
              if (state.selectedSequence != null)
                Expanded(
                  child: Panel.tabs(
                    label: "${state.selectedSequence!.name}",
                    tabs: [
                      tabs.Tab(label: "Cue List", child: CueList(sequence: state.selectedSequence!, activeCue: sequenceStates[state.selectedSequenceId]?.cueId)),
                      tabs.Tab(label: "Track Sheet", child: TrackSheet(sequence: state.selectedSequence!, activeCue: sequenceStates[state.selectedSequenceId]?.cueId)),
                      tabs.Tab(label: "Sequence Settings", child: SequencerSettings(sequence: state.selectedSequence!)),
                    ],
                  ),
                ),
            ],
          );
        }
      ),
    );
  }

  _deleteSequence(int sequenceId) {
    context.read<SequencerBloc>().add(DeleteSequence(sequenceId));
  }

  _sequenceGo(int sequenceId) {
    context.read<SequencerApi>().sequenceGoForward(sequenceId);
  }

  _sequenceStop(int sequenceId) {
    context.read<SequencerApi>().sequenceStop(sequenceId);
  }

  _selectSequence(Sequence sequence) {
    context.read<SequencerBloc>().add(SelectSequence(sequence: sequence.id));
  }
}

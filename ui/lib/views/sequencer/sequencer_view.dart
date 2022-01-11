import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/settings/hotkeys/hotkey_provider.dart';
import 'package:mizer/state/fixtures_bloc.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/panel.dart';

import 'cue_contents.dart';
import 'cue_list.dart';
import 'sequence_list.dart';

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
      hotkeyMap: {
        "add_sequence": () => _addSequence(),
      },
      child: BlocBuilder<SequencerBloc, SequencerState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Panel(
                  label: "Sequences",
                  child: SequenceList(selectSequence: _selectSequence, selectedSequence: state.selectedSequence, sequenceStates: sequenceStates),
                  actions: [
                    PanelAction(hotkeyId: "add_sequence", label: "Add", onClick: () => _addSequence()),
                    PanelAction(hotkeyId: "delete", label: "Delete", onClick: () => _deleteSequence(state.selectedSequenceId!), disabled: state.selectedSequenceId == null),
                  ],
                ),
              ),
              if (state.selectedSequence != null)
                Expanded(
                  child: Panel(
                    label: "Cue List - ${state.selectedSequence!.name}",
                    child: CueList(sequence: state.selectedSequence!, onSelectCue: _selectCue, selectedCue: state.selectedCue, activeCue: sequenceStates[state.selectedSequenceId]?.cueId),
                    actions: [
                      PanelAction(label: "Go", onClick: () => _sequenceGo(state.selectedSequenceId!)),
                    ],
                  ),
                ),
              if (state.selectedCue != null)
                Expanded(
                    child: Panel(label: "Cue Contents - ${state.selectedCue!.name}", child: CueContents(cue: state.selectedCue!)))
            ],
          );
        }
      ),
    );
  }

  _addSequence() {
    context.read<SequencerBloc>().add(AddSequence());
  }

  _deleteSequence(int sequenceId) {
    context.read<SequencerBloc>().add(DeleteSequence(sequenceId));
  }

  _sequenceGo(int sequenceId) {
    context.read<SequencerApi>().sequenceGo(sequenceId);
  }

  _selectSequence(Sequence sequence) {
    context.read<SequencerBloc>().add(SelectSequence(sequence: sequence.id));
  }

  _selectCue(Cue cue) {
    context.read<SequencerBloc>().add(SelectCue(cue: cue.id));
  }
}

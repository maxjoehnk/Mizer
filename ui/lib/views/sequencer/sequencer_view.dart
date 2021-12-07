import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

import 'cue_contents.dart';
import 'cue_list.dart';
import 'sequence_list.dart';

class SequencerView extends StatefulWidget {
  const SequencerView({Key? key}) : super(key: key);

  @override
  State<SequencerView> createState() => _SequencerViewState();
}

class _SequencerViewState extends State<SequencerView> {
  @override
  Widget build(BuildContext context) {
    context.read<SequencerBloc>().add(FetchSequences());
    return BlocBuilder<SequencerBloc, SequencerState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Panel(
                label: "Sequences",
                child: SequenceList(selectSequence: _selectSequence, selectedSequence: state.selectedSequence),
                actions: [
                  PanelAction(label: "Add", onClick: () => _addSequence()),
                  PanelAction(label: "Delete", onClick: () => _deleteSequence(state.selectedSequenceId!), disabled: state.selectedSequenceId == null),
                ],
              ),
            ),
            if (state.selectedSequence != null)
              Expanded(
                child: Panel(
                  label: "Cue List - ${state.selectedSequence!.name}",
                  child: CueList(sequence: state.selectedSequence!, onSelectCue: _selectCue, selectedCue: state.selectedCue),
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

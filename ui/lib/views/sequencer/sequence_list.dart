import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/table/table.dart';

class SequenceList extends StatelessWidget {
  final Sequence? selectedSequence;
  final Function(Sequence) selectSequence;

  const SequenceList({required this.selectSequence, this.selectedSequence, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(
        builder: (context, state) {
          return _list(state.sequences);
        });
  }

  Widget _list(List<Sequence> sequences) {
    return SingleChildScrollView(
      child: MizerTable(
        columns: const [Text("Name"), Text("Cues")],
        rows: sequences.map(_sequenceRow).toList(),
      ),
    );
  }

  MizerTableRow _sequenceRow(Sequence sequence) {
    bool selected = sequence == selectedSequence;
    return MizerTableRow(
      cells: [
        Text(sequence.name),
        Text(sequence.cues.length.toString()),
      ],
      onTap: () {
        if (!selected) {
          selectSequence(sequence);
        }
      },
      selected: selected,
    );
  }
}

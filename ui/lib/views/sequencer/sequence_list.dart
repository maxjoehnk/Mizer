import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/table/table.dart';

class SequenceList extends StatelessWidget {
  final Sequence? selectedSequence;
  final Function(Sequence) selectSequence;
  final Map<int, SequenceState> sequenceStates;

  const SequenceList({required this.selectSequence, this.selectedSequence, required this.sequenceStates, Key? key}) : super(key: key);

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
        columnWidths: {
          0: FixedColumnWidth(64),
        },
        columns: const [Text(""), Text("Name"), Text("Cues"), Text("Wrap Around")],
        rows: sequences.map(_sequenceRow).toList(),
      ),
    );
  }

  MizerTableRow _sequenceRow(Sequence sequence) {
    bool selected = sequence == selectedSequence;
    bool active = this.sequenceStates[sequence.id]?.active ?? false;
    return MizerTableRow(
      cells: [
        active ? Icon(Icons.play_arrow, size: 24) : Container(),
        Text(sequence.name),
        Text(sequence.cues.length.toString()),
        Text(sequence.wrapAround ? "Wrap" : "No Wrap"),
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

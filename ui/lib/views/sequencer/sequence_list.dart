import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';

class SequenceList extends StatelessWidget {
  final Sequence? selectedSequence;
  final Function(Sequence) selectSequence;

  const SequenceList({required this.selectSequence, this.selectedSequence, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, Sequences>(
        builder: (context, state) {
          return _list(state.sequences);
        });
  }

  Widget _list(List<Sequence> sequences) {
    return SingleChildScrollView(
      child: DataTable(
        showCheckboxColumn: false,
        columns: [DataColumn(label: Text("Name")), DataColumn(label: Text("Cues"))],
        rows: sequences.map(_sequenceRow).toList(),
      ),
    );
  }

  DataRow _sequenceRow(Sequence sequence) {
    return DataRow(
      cells: [
        DataCell(Text(sequence.name)),
        DataCell(Text(sequence.cues.length.toString())),
      ],
      onSelectChanged: (selected) {
        if (selected!) {
          selectSequence(sequence);
        }
      },
      selected: sequence == selectedSequence,
    );
  }
}

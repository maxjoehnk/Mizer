import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:provider/src/provider.dart';

class SequenceList extends StatelessWidget {
  final Sequence selectedSequence;
  final Function(Sequence) selectSequence;

  const SequenceList({this.selectSequence, this.selectedSequence, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<SequencerApi>().getSequences(),
        builder: (context, AsyncSnapshot<Sequences> data) {
          if (data.hasData) {
            return _list(data.data.sequences);
          }
          return Container();
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
        if (selected) {
          selectSequence(sequence);
        }
      },
      selected: sequence == selectedSequence,
    );
  }
}

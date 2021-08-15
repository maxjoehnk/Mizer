import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

class SequencerView extends StatefulWidget {
  const SequencerView({Key key}) : super(key: key);

  @override
  State<SequencerView> createState() => _SequencerViewState();
}

class _SequencerViewState extends State<SequencerView> {
  Sequence _sequence;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Panel(
            label: "Sequences",
            child: FutureBuilder(
                future: context.read<SequencerApi>().getSequences(),
                builder: (context, AsyncSnapshot<Sequences> data) {
                  if (data.hasData) {
                    return ListView(children: data.data.sequences.map(_sequenceRow).toList());
                  }
                  return Container();
                }),
            actions: [PanelAction(label: "Add", onClick: () => _addSequence())],
          ),
        ),
        if (_sequence != null)
          Expanded(
            child: Panel(
              label: "Cue List - ${_sequence.name}",
              child: CueList(sequence: _sequence),
              actions: [
                PanelAction(label: "Go", onClick: () => _sequenceGo()),
              ],
            ),
          )
      ],
    );
  }

  _addSequence() {}

  _sequenceGo() {
    context.read<SequencerApi>().sequenceGo(_sequence.id);
  }

  Widget _sequenceRow(Sequence sequence) {
    return ListTile(
      title: Text(sequence.name),
      subtitle: Text(sequence.cues.length == 1 ? "1 Cue" : "${sequence.cues.length} Cues"),
      onTap: () => _selectSequence(sequence),
    );
  }

  _selectSequence(Sequence sequence) {
    setState(() => _sequence = sequence);
  }
}

class CueList extends StatelessWidget {
  final Sequence sequence;

  const CueList({this.sequence, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
        headingRowHeight: 40,
        dataRowHeight: 40,
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Trigger")),
          DataColumn(label: Text("Loop"))
        ],
        rows: sequence.cues
            .map((cue) => DataRow(cells: [
                  DataCell(Text(cue.id.toString())),
                  DataCell(Text(cue.name)),
                  DataCell(Text(cue.trigger.toLabel())),
                  DataCell(Text(cue.loop ? "Loop" : ""))
                ]))
            .toList());
  }
}

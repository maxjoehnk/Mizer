// @dart=2.11
import 'package:flutter/material.dart';
import 'package:mizer/protos/sequencer.dart';

class CueList extends StatelessWidget {
  final Sequence sequence;
  final Function(Cue) onSelectCue;
  final Cue selectedCue;

  const CueList({this.sequence, this.onSelectCue, this.selectedCue, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
          headingRowHeight: 40,
          dataRowHeight: 40,
          showCheckboxColumn: false,
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Trigger")),
            DataColumn(label: Text("Loop"))
          ],
          rows: sequence.cues
              .map((cue) => DataRow(
                      cells: [
                        DataCell(Text(cue.id.toString())),
                        DataCell(Text(cue.name)),
                        DataCell(Text(cue.trigger.toLabel())),
                        DataCell(Text(cue.loop ? "Loop" : ""))
                      ],
                      selected: cue == selectedCue,
                      onSelectChanged: (selected) {
                        if (selected) {
                          this.onSelectCue(cue);
                        }
                      }))
              .toList()),
    );
  }
}

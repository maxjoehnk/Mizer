import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/popup_menu/popup_menu_route.dart';

class CueList extends StatelessWidget {
  final Sequence sequence;
  final Function(Cue) onSelectCue;
  final Cue? selectedCue;

  const CueList({required this.sequence, required this.onSelectCue, this.selectedCue, Key? key})
      : super(key: key);

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
                        DataCell(Text(cue.trigger.toLabel()), onTapDown: (details) {
                          Navigator.of(context).push(PopupMenuRoute(
                              position: details.globalPosition,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(4)),
                                width: 150,
                                height: 200,
                                child: Column(
                                  children: [
                                    Text("Trigger"),
                                    Expanded(
                                      child: ListView(children: [
                                        ListTile(
                                            title: Text("Go"),
                                            hoverColor: Colors.black12,
                                            onTap: () =>
                                                _updateCueTrigger(context, cue, CueTrigger.GO)),
                                        ListTile(
                                            title: Text("Follow"),
                                            hoverColor: Colors.black12,
                                            onTap: () =>
                                                _updateCueTrigger(context, cue, CueTrigger.FOLLOW)),
                                        ListTile(
                                            title: Text("Time"),
                                            hoverColor: Colors.black12,
                                            onTap: () =>
                                                _updateCueTrigger(context, cue, CueTrigger.TIME)),
                                      ]),
                                    ),
                                  ],
                                ),
                              )));
                        }, onTap: () {}),
                        DataCell(Text(cue.loop ? "Loop" : ""))
                      ],
                      selected: cue == selectedCue,
                      onSelectChanged: (selected) {
                        if (selected!) {
                          this.onSelectCue(cue);
                        }
                      }))
              .toList()),
    );
  }

  void _updateCueTrigger(BuildContext context, Cue cue, CueTrigger trigger) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueTrigger(sequence: sequence.id, cue: cue.id, trigger: trigger));
    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_select.dart';
import 'package:mizer/widgets/table/table.dart';

class CueList extends StatelessWidget {
  final Sequence sequence;
  final Function(Cue) onSelectCue;
  final Cue? selectedCue;
  final int? activeCue;

  const CueList({required this.sequence, required this.onSelectCue, this.selectedCue, this.activeCue, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MizerTable(
          columns: const [Text("ID"), Text("Name"), Text("Trigger"), Text("Loop")],
          rows: sequence.cues
              .map((cue) {
                bool selected = cue == selectedCue;
                var onTap = () {
                  if (!selected) {
                    this.onSelectCue(cue);
                  }
                };
                return MizerTableRow(
                      cells: [
                        Text(cue.id.toString()),
                        PopupTableCell(
                            child: Text(cue.name),
                            popup: PopupInput(
                              title: "Name",
                              value: cue.name,
                              onChange: (name) => _updateCueName(context, cue, name),
                            ), onTap: onTap),
                        PopupTableCell(
                            child: Text(cue.trigger.toLabel()),
                            popup: PopupSelect(title: "Trigger", items: [
                              SelectItem(
                                  title: "Go",
                                  onTap: () =>
                                      _updateCueTrigger(context, cue, CueTrigger.GO)),
                              SelectItem(
                                  title: "Follow",
                                  onTap: () =>
                                      _updateCueTrigger(context, cue, CueTrigger.FOLLOW)),
                              SelectItem(
                                  title: "Time",
                                  onTap: () =>
                                      _updateCueTrigger(context, cue, CueTrigger.TIME)),
                            ]),
                            onTap: onTap),
                        Text(cue.loop ? "Loop" : "")
                      ],
                      selected: selected,
                      highlight: activeCue == cue.id,
                      onTap: onTap);
              })
              .toList()),
    );
  }

  void _updateCueName(BuildContext context, Cue cue, String name) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueName(sequence: sequence.id, cue: cue.id, name: name));
  }

  void _updateCueTrigger(BuildContext context, Cue cue, CueTrigger trigger) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueTrigger(sequence: sequence.id, cue: cue.id, trigger: trigger));
    Navigator.of(context).pop();
  }
}

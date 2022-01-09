import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/popup_menu/popup_menu_route.dart';
import 'package:mizer/widgets/popup_select/popup_select.dart';
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
                        Text(cue.name),
                        GestureDetector(
                            child: Text(cue.trigger.toLabel()),
                            behavior: HitTestBehavior.translucent,
                            onTap: onTap,
                            onSecondaryTapDown: (details) {
                              Navigator.of(context).push(PopupMenuRoute(
                                  position: details.globalPosition,
                                  child: PopupSelect(title: "Trigger", items: [
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
                                  ])));
                            }),
                        Text(cue.loop ? "Loop" : "")
                      ],
                      selected: selected,
                      highlight: activeCue == cue.id,
                      onTap: onTap);
              })
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

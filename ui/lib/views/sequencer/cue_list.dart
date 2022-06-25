import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/views/sequencer/track_sheet.dart';
import 'package:mizer/widgets/popup/popup_direct_time_input.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_select.dart';
import 'package:mizer/widgets/popup/popup_time_input.dart';
import 'package:mizer/widgets/table/table.dart';

class CueList extends StatelessWidget {
  final Sequence sequence;
  final int? activeCue;

  const CueList(
      {required this.sequence,
      this.activeCue,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MizerTable(
          columns: [
            Center(child: Text("ID")),
            Center(child: Text("Name")),
            _twoLineHeader("Trigger", "Type"),
            _twoLineHeader("Trigger", "Time"),
            _twoLineHeader("Cue", "Fade"),
            _twoLineHeader("Cue", "Delay"),
            _twoLineHeader("Dimmer", "Fade"),
            _twoLineHeader("Dimmer", "Delay"),
            _twoLineHeader("Position", "Fade"),
            _twoLineHeader("Position", "Delay"),
            _twoLineHeader("Color", "Fade"),
            _twoLineHeader("Color", "Delay"),
          ],
          rows: sequence.cues.map((cue) {
            return MizerTableRow(cells: [
              Text(cue.id.toString()),
              PopupTableCell(
                  child: Text(cue.name),
                  popup: PopupInput(
                    title: "Name",
                    value: cue.name,
                    onChange: (name) => _updateCueName(context, cue, name),
                  )),
              PopupTableCell(
                  child: Center(child: Text(cue.trigger.toLabel())),
                  popup: PopupSelect(title: "Trigger", items: [
                    SelectItem(
                        title: "Go", onTap: () => _updateCueTrigger(context, cue, CueTrigger_Type.GO)),
                    SelectItem(
                        title: "Follow",
                        onTap: () => _updateCueTrigger(context, cue, CueTrigger_Type.FOLLOW)),
                    SelectItem(
                        title: "Time",
                        onTap: () => _updateCueTrigger(context, cue, CueTrigger_Type.TIME)),
                  ])),
              PopupTableCell(
                  popup: PopupDirectTimeInput(time: cue.trigger.time, onEnter: (value) => _updateCueTriggerTime(context, cue, value)),
                  child: Text(cue.trigger.time.toDisplay())),
              PopupTableCell(
                  popup: PopupTimeInput(timer: cue.cueTimings.fade, onEnter: (value) => _updateCueFade(context, cue, value)),
                  child: Text(cue.cueTimings.hasFade() ? cue.cueTimings.fade.toDisplay() : "")),
              PopupTableCell(
                  popup: PopupTimeInput(timer: cue.cueTimings.delay, onEnter: (value) => _updateCueDelay(context, cue, value)),
                  child: Text(cue.cueTimings.hasDelay() ? cue.cueTimings.delay.toDisplay() : "")),
              Text(cue.dimmerTimings.hasFade() ? cue.dimmerTimings.fade.toDisplay() : ""),
              Text(cue.dimmerTimings.hasDelay() ? cue.dimmerTimings.delay.toDisplay() : ""),
              Text(cue.positionTimings.hasFade() ? cue.positionTimings.fade.toDisplay() : ""),
              Text(cue.positionTimings.hasDelay() ? cue.positionTimings.delay.toDisplay() : ""),
              Text(cue.colorTimings.hasFade() ? cue.colorTimings.fade.toDisplay() : ""),
              Text(cue.colorTimings.hasDelay() ? cue.colorTimings.delay.toDisplay() : ""),
            ], highlight: activeCue == cue.id);
          }).toList()),
    );
  }

  void _updateCueName(BuildContext context, Cue cue, String name) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueName(sequence: sequence.id, cue: cue.id, name: name));
  }

  void _updateCueTrigger(BuildContext context, Cue cue, CueTrigger_Type trigger) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueTrigger(sequence: sequence.id, cue: cue.id, trigger: trigger));
    Navigator.of(context).pop();
  }

  void _updateCueTriggerTime(BuildContext context, Cue cue, CueTime? value) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueTriggerTime(sequence: sequence.id, cue: cue.id, time: value));
  }

  void _updateCueFade(BuildContext context, Cue cue, CueTimer? value) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueFade(cue: cue.id, time: value));
  }

  void _updateCueDelay(BuildContext context, Cue cue, CueTimer? value) {
    context
        .read<SequencerBloc>()
        .add(UpdateCueDelay(cue: cue.id, time: value));
  }

  Widget _twoLineHeader(String line1, String line2) {
    return Column(mainAxisSize: MainAxisSize.min, children: [Text(line1), Text(line2)]);
  }
}

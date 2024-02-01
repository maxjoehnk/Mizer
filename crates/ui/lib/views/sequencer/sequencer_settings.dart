import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/controls/select.dart';

const Map<FixturePriority, String> PriorityLabels = {
  FixturePriority.PRIORITY_HTP: "HTP",
  FixturePriority.PRIORITY_LTP_HIGHEST: "Highest",
  FixturePriority.PRIORITY_LTP_HIGH: "High",
  FixturePriority.PRIORITY_LTP_NORMAL: "LTP",
  FixturePriority.PRIORITY_LTP_LOW: "Low",
  FixturePriority.PRIORITY_LTP_LOWEST: "Lowest",
};

class SequencerSettings extends StatelessWidget {
  final Sequence sequence;

  const SequencerSettings({required this.sequence, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SequenceSetting(
          label: "WrapAround",
          child: Switch(
              value: sequence.wrapAround,
              onChanged: (wrapAround) => _updateWrapAround(context, wrapAround))),
      SequenceSetting(
          label: "Stop on Last Cue",
          child: Switch(
              value: sequence.stopOnLastCue,
              onChanged: (stopOnLastCue) => _updateStopOnLastCue(context, stopOnLastCue))),
      SequenceSetting(
          label: "Priority",
          child: MizerSelect<FixturePriority>(
              value: sequence.priority,
              options: FixturePriority.values
                  .map((p) => SelectOption(
                        label: PriorityLabels[p]!,
                        value: p,
                      ))
                  .toList(),
              onChanged: (priority) => _updatePriority(context, priority)))
    ]);
  }

  _updateWrapAround(BuildContext context, bool wrapAround) {
    SequencerBloc bloc = context.read();
    bloc.add(UpdateWrapAround(sequence: sequence.id, wrapAround: wrapAround));
  }

  _updateStopOnLastCue(BuildContext context, bool stopOnLastCue) {
    SequencerBloc bloc = context.read();
    bloc.add(UpdateStopOnLastCue(sequence: sequence.id, stopOnLastCue: stopOnLastCue));
  }

  _updatePriority(BuildContext context, FixturePriority priority) {
    SequencerBloc bloc = context.read();
    bloc.add(UpdatePriority(sequence: sequence.id, priority: priority));
  }
}

class SequenceSetting extends StatelessWidget {
  final String label;
  final Widget child;

  const SequenceSetting({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black12,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: textTheme.bodySmall),
          Expanded(child: Center(child: child)),
        ]),
        width: 200,
        height: 72);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/i18n.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/boolean_field.dart';
import 'package:mizer/views/nodes/widgets/properties/fields/enum_field.dart';
import 'package:mizer/widgets/controls/select.dart';

Map<FixturePriority, String Function()> PriorityLabels = {
  FixturePriority.PRIORITY_HTP: () => "HTP".i18n,
  FixturePriority.PRIORITY_LTP_HIGHEST: () => "Highest".i18n,
  FixturePriority.PRIORITY_LTP_HIGH: () => "High".i18n,
  FixturePriority.PRIORITY_LTP_NORMAL: () => "LTP".i18n,
  FixturePriority.PRIORITY_LTP_LOW: () => "Low".i18n,
  FixturePriority.PRIORITY_LTP_LOWEST: () => "Lowest".i18n,
};

class SequencerSettings extends StatelessWidget {
  final Sequence sequence;

  const SequencerSettings({required this.sequence, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 8, children: [
      SizedBox(
        width: GRID_8_SIZE,
        child: BooleanField(
          label: "Wrap Around".i18n,
          vertical: true,
          value: sequence.wrapAround,
          onUpdate: (wrapAround) => _updateWrapAround(context, wrapAround),
        ),
      ),
      SizedBox(
        width: GRID_8_SIZE,
        child: BooleanField(
          label: "Stop on Last Cue".i18n,
          vertical: true,
          value: sequence.stopOnLastCue,
          onUpdate: (stopOnLastCue) => _updateStopOnLastCue(context, stopOnLastCue),
        ),
      ),
      SizedBox(
          width: GRID_8_SIZE,
          child: EnumField<FixturePriority>(
              label: "Priority".i18n,
              vertical: true,
              initialValue: sequence.priority,
              items: FixturePriority.values
                  .map((p) => SelectOption(
                        label: PriorityLabels[p]!(),
                        value: p,
                      ))
                  .toList(),
              onUpdate: (priority) => _updatePriority(context, priority))),
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

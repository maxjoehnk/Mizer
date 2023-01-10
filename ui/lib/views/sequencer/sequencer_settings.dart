import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/state/sequencer_bloc.dart';

class SequencerSettings extends StatelessWidget {
  final Sequence sequence;

  const SequencerSettings({required this.sequence, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black12,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text("Wrap Around"),
          Switch(
              value: sequence.wrapAround,
              onChanged: (wrapAround) => _updateWrapAround(context, wrapAround)),
        ]),
      ),
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black12,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text("Stop on Last Cue"),
          Switch(
              value: sequence.stopOnLastCue,
              onChanged: (stopOnLastCue) => _updateStopOnLastCue(context, stopOnLastCue)),
        ]),
      )
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
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/protos/sequencer.pb.dart';
import 'package:mizer/state/sequencer_bloc.dart';

class SequencerSettings extends StatelessWidget {
  final Sequence sequence;

  const SequencerSettings({required this.sequence, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black12,
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Wrap Around"),
            Switch(value: sequence.wrapAround, onChanged: (wrapAround) => _updateWrapAround(context, wrapAround)),
          ]),
        )
      ]),
    );
  }

  _updateWrapAround(BuildContext context, bool wrapAround) {
    SequencerBloc bloc = context.read();
    bloc.add(UpdateWrapAround(sequence: sequence.id, wrapAround: wrapAround));
  }
}

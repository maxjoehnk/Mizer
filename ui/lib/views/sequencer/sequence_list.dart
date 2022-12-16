import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_route.dart';

class SequenceList extends StatelessWidget {
  final Sequence? selectedSequence;
  final Function(Sequence) selectSequence;
  final Map<int, SequenceState> sequenceStates;

  const SequenceList(
      {required this.selectSequence, this.selectedSequence, required this.sequenceStates, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(builder: (context, state) {
      return _list(context, state.sequences);
    });
  }

  Widget _list(BuildContext context, List<Sequence> sequences) {
    return GridView(
      padding: const EdgeInsets.all(4),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisExtent: 100,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      children: sequences.map((sequence) => _sequenceRow(context, sequence)).toList(),
    );
  }

  Widget _sequenceRow(BuildContext context, Sequence sequence) {
    bool selected = sequence == selectedSequence;
    bool active = this.sequenceStates[sequence.id]?.active ?? false;
    var onTap = () {
      if (!selected) {
        selectSequence(sequence);
      }
    };

    return GestureDetector(
      onSecondaryTapDown: (details) => Navigator.of(context).push(MizerPopupRoute(
          position: details.globalPosition,
          child: PopupInput(
            title: "Name",
            value: sequence.name,
            onChange: (name) => _updateSequenceName(context, sequence, name),
          ))),
      child: Hoverable(
        onTap: onTap,
        builder: (hovered) => Container(
          padding: const EdgeInsets.all(2),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: hovered ? Colors.white10 : Colors.transparent,
            border: Border.all(color: selected ? Colors.deepOrange : Colors.white10, width: 4),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(sequence.id.toString(), textAlign: TextAlign.start),
            Spacer(),
            AutoSizeText(sequence.name, textAlign: TextAlign.center, maxLines: 2),
            Container(height: 24, child: active ? Icon(Icons.play_arrow) : null),
          ]),
        ),
      ),
    );
  }

  void _updateSequenceName(BuildContext context, Sequence sequence, String name) {
    context.read<SequencerBloc>().add(UpdateSequenceName(sequence: sequence.id, name: name));
  }
}

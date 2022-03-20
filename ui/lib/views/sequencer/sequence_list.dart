import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_select.dart';
import 'package:mizer/widgets/table/table.dart';

class SequenceList extends StatelessWidget {
  final Sequence? selectedSequence;
  final Function(Sequence) selectSequence;
  final Map<int, SequenceState> sequenceStates;

  const SequenceList({required this.selectSequence, this.selectedSequence, required this.sequenceStates, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(
        builder: (context, state) {
          return _list(context, state.sequences);
        });
  }

  Widget _list(BuildContext context, List<Sequence> sequences) {
    return SingleChildScrollView(
      child: MizerTable(
        columnWidths: {
          0: FixedColumnWidth(64),
        },
        columns: const [Text(""), Text("Name"), Text("Cues"), Text("Wrap Around")],
        rows: sequences.map((sequence) => _sequenceRow(context, sequence)).toList(),
      ),
    );
  }

  MizerTableRow _sequenceRow(BuildContext context, Sequence sequence) {
    bool selected = sequence == selectedSequence;
    bool active = this.sequenceStates[sequence.id]?.active ?? false;
    var onTap = () {
        if (!selected) {
          selectSequence(sequence);
        }
      };
    return MizerTableRow(
      cells: [
        active ? Icon(Icons.play_arrow, size: 24) : Container(),
        PopupTableCell(
            child: Text(sequence.name),
            popup: PopupInput(
              title: "Name",
              value: sequence.name,
              onChange: (name) => _updateSequenceName(context, sequence, name),
            ), onTap: onTap),
        Text(sequence.cues.length.toString()),
        PopupTableCell(
          child: Text(sequence.wrapAround ? "Wrap" : "No Wrap"),
          popup: PopupSelect(title: "Wrap Around", items: [
            SelectItem(
                title: "Wrap",
                onTap: () =>
                    _updateWrapAround(context, sequence, true)),
            SelectItem(
                title: "No Wrap",
                onTap: () =>
                    _updateWrapAround(context, sequence, false)),
          ]), onTap: onTap,
        ),
      ],
      onTap: onTap,
      selected: selected,
    );
  }

  void _updateSequenceName(BuildContext context, Sequence sequence, String name) {
    context
        .read<SequencerBloc>()
        .add(UpdateSequenceName(sequence: sequence.id, name: name));
  }

  void _updateWrapAround(BuildContext context, Sequence sequence, bool wrapAround) {
    context
        .read<SequencerBloc>()
        .add(UpdateWrapAround(sequence: sequence.id, wrapAround: wrapAround));
  }
}

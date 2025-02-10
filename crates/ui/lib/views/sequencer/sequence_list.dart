import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/hoverable.dart';
import 'package:mizer/widgets/grid/panel_sizing.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:mizer/widgets/popup/popup_input.dart';
import 'package:mizer/widgets/popup/popup_route.dart';

class SequenceList extends StatelessWidget {
  final Sequence? selectedSequence;
  final Function(Sequence) selectSequence;
  final Map<int, SequenceState> sequenceStates;
  final String? searchQuery;

  const SequenceList(
      {required this.selectSequence,
      this.selectedSequence,
      required this.sequenceStates,
      this.searchQuery,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SequencerBloc, SequencerState>(builder: (context, state) {
      return _list(context, state.sequences);
    });
  }

  Widget _list(BuildContext context, List<Sequence> sequences) {
    return PanelSizing(
      columns: 18,
      rows: 3,
      child: PanelGrid(
        children: [
          ...sequences
              .search([(s) => s.name], searchQuery)
              .map((sequence) => _sequence(context, sequence)),
          ...List.filled((18 * 3) - sequences.length, PanelGridTile.empty())
        ]
      ),
    );
  }

  Widget _sequence(BuildContext context, Sequence sequence) {
    bool selected = sequence == selectedSequence;
    bool active = this.sequenceStates[sequence.id]?.active ?? false;
    double rate = this.sequenceStates[sequence.id]?.rate ?? 1;
    var onTap = () {
      if (!selected) {
        selectSequence(sequence);
      }
    };

    return PanelGridTile(
      onTap: onTap,
      active: active,
      onSecondaryTapDown: (details) => Navigator.of(context).push(MizerPopupRoute(
          position: details.globalPosition,
          child: PopupInput(
            title: "Name",
            value: sequence.name,
            onChange: (name) => _updateSequenceName(context, sequence, name),
          ))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text(sequence.id.toString(), textAlign: TextAlign.start)),
          Text((rate * 100).toStringAsFixed(0) + "%"),
        ]),
        Spacer(),
        AutoSizeText(sequence.name, textAlign: TextAlign.center, maxLines: 2),
        Container(height: 24, child: active ? Icon(Icons.play_arrow) : null),
      ])
    );
  }

  void _updateSequenceName(BuildContext context, Sequence sequence, String name) {
    context.read<SequencerBloc>().add(UpdateSequenceName(sequence: sequence.id, name: name));
  }
}

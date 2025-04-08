import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/dialogs/name_dialog.dart';
import 'package:mizer/extensions/list_extensions.dart';
import 'package:mizer/state/sequencer_bloc.dart';
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/grid/panel_grid.dart';
import 'package:mizer/widgets/high_contrast_text.dart';
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
    return PanelGrid(children: [
      ...sequences
          .search([(s) => s.name], searchQuery).map((sequence) => _sequence(context, sequence)),
      ...List.filled((300) - sequences.length, PanelGridTile.empty())
    ]);
  }

  Widget _sequence(BuildContext context, Sequence sequence) {
    bool selected = sequence == selectedSequence;
    var sequenceState = this.sequenceStates[sequence.id];
    bool active = sequenceState?.active ?? false;
    double rate = sequenceState?.rate ?? 1;

    int currentCueIndex = sequence.cues.indexWhere((c) => c.id == sequenceState?.cueId);
    if (currentCueIndex == -1) {
      currentCueIndex = 0;
    }
    Cue activeCue = sequence.cues[currentCueIndex];
    Cue? nextCue =
        currentCueIndex + 1 < sequence.cues.length ? sequence.cues[currentCueIndex + 1] : null;
    Cue? previousCue = currentCueIndex - 1 >= 0 ? sequence.cues[currentCueIndex - 1] : null;

    var onTap = () {
      if (!selected) {
        selectSequence(sequence);
      }
    };

    return PanelGridTile(
        onTap: onTap,
        active: active,
        selected: selected,
        onSecondaryTapDown: (details) => context.showNameDialog(name: sequence.name).then((name) {
          if (name != null) {
            _updateSequenceName(context, sequence, name);
          }
        }),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: 11,
            child: Row(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(sequence.id.toString(), textAlign: TextAlign.start, style: TextStyle(fontSize: 12)),
              )),
              Text((rate * 100).toStringAsFixed(0) + "%", style: TextStyle(fontSize: 12)),
            ]),
          ),
          SizedBox(
            height: 37,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                  child: HighContrastText(sequence.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      autoSize: AutoSize(minFontSize: 12))),
            ),
          ),
          Spacer(),
          if (previousCue != null) InactiveCue(cue: previousCue),
          ActiveCue(cue: activeCue, active: active),
          if (nextCue != null) InactiveCue(cue: nextCue)
        ]));
  }

  void _updateSequenceName(BuildContext context, Sequence sequence, String name) {
    context.read<SequencerBloc>().add(UpdateSequenceName(sequence: sequence.id, name: name));
  }
}

class ActiveCue extends StatelessWidget {
  final bool active;
  final Cue cue;

  const ActiveCue({super.key, required this.cue, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 12,
        color: active ? Colors.deepOrange.shade500 : Grey400,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(cue.id.toString(), textAlign: TextAlign.start, style: TextStyle(fontSize: 11)),
              ),
            ),
            Center(child: Text(cue.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 11))),
          ],
        ));
  }
}

class InactiveCue extends StatelessWidget {
  final Cue cue;

  const InactiveCue({super.key, required this.cue});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 9,
        color: Grey600,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(cue.id.toString(), textAlign: TextAlign.start, style: TextStyle(fontSize: 9)),
              ),
            ),
            Center(child: Text(cue.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 9))),
          ],
        ));
  }
}

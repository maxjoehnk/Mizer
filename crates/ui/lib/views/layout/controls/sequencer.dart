import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/protos/layouts.pb.dart'
    show ControlSize, SequencerControlBehavior, SequencerControlBehavior_ClickBehavior;
import 'package:mizer/widgets/grid/grid_tile.dart';
import 'package:mizer/widgets/high_contrast_text.dart';
import 'package:provider/provider.dart';

class SequencerControl extends StatelessWidget {
  final String label;
  final Color? color;
  final int sequenceId;
  final Map<int, SequenceState> state;
  final ControlSize size;
  final SequencerControlBehavior behavior;

  const SequencerControl(
      {required this.label,
      this.color,
      required this.sequenceId,
      required this.state,
      required this.size,
      required this.behavior,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sequencerApi = context.read<SequencerApi>();
    var textTheme = Theme.of(context).textTheme;

    return FutureBuilder<Sequence>(
        future: sequencerApi.getSequence(sequenceId),
        builder: (context, state) {
          return PanelGridTile(
              color: color,
            width: size.width.toInt(),
            height: size.height.toInt(),
            active: this.state[sequenceId]?.active ?? false,
            onTap: () {
              if (behavior.clickBehavior == SequencerControlBehavior_ClickBehavior.TOGGLE) {
                _sequenceToggle(sequencerApi);
              }
              if (behavior.clickBehavior == SequencerControlBehavior_ClickBehavior.GO_FORWARD) {
                _sequenceGo(sequencerApi);
              }
            },
            child: state.hasData ? _cueView(state.data!, textTheme) : Container(),
          );
        });
  }

  void _sequenceToggle(SequencerApi sequencerApi) {
    if (this.state[sequenceId]?.active ?? false) {
      sequencerApi.sequenceStop(sequenceId);
    } else {
      sequencerApi.sequenceGoForward(sequenceId);
    }
  }

  void _sequenceGo(SequencerApi sequencerApi) {
    sequencerApi.sequenceGoForward(sequenceId);
  }

  Widget _cueView(Sequence sequence, TextTheme textTheme) {
    var sequenceState = state[sequence.id];

    return sequence.cues.length > 1
        ? _multiCueView(sequence, textTheme, sequenceState)
        : _singleCueView(sequence, textTheme, sequenceState);
  }

  Widget _multiCueView(Sequence sequence, TextTheme textTheme, SequenceState? sequenceState) {
    var rows = 2 + (size.height.toInt() - 1) * 4;

    return _cueListView(sequence, textTheme, rows, sequenceState);
  }

  Widget _cueListView(
      Sequence sequence, TextTheme textTheme, int rows, SequenceState? sequenceState) {
    var activeCue = sequence.cues.firstWhereOrNull((cue) => cue.id == sequenceState?.cueId);
    if (activeCue == null) {
      return _singleCueView(sequence, textTheme, sequenceState);
    }
    var activeCueIndex = sequence.cues.indexOf(activeCue);
    List<Cue> cues = [];
    if (rows > 2) {
      var previousCue = activeCueIndex > 0 ? sequence.cues[activeCueIndex - 1] : sequence.cues.last;
      cues.add(previousCue);
    }
    cues.add(activeCue);
    var cueList;
    if (sequence.wrapAround) {
      cueList = [...sequence.cues, ...sequence.cues];
    } else {
      cueList = sequence.cues;
    }
    var nextCues =
        cueList.skip(activeCueIndex + 1).take((rows - 2).clamp(1, sequence.cues.length - 1));
    cues.addAll(nextCues);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: _sequenceHeader(sequence, textTheme, sequenceState?.active ?? false),
      ),
      ...cues.map(
          (cue) => _cueRow(cue, textTheme, sequenceState?.cueId, sequenceState?.active ?? false)),
    ]);
  }

  Widget _cueRow(Cue cue, TextTheme textTheme, int? cueId, bool active) {
    var activeColor = active ? Colors.orange.shade900 : Colors.black45;
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white54)),
          color: cue.id == cueId ? activeColor : Colors.black26),
      child: Text(cue.name,
          textAlign: TextAlign.center, style: textTheme.bodySmall!.copyWith(fontSize: 10)),
    );
  }

  Widget _singleCueView(Sequence sequence, TextTheme textTheme, SequenceState? sequenceState) {
    return _sequenceHeader(sequence, textTheme, sequenceState?.active ?? false);
  }

  Widget _sequenceHeader(Sequence sequence, TextTheme textTheme, bool active) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Center(
        child: HighContrastText(sequence.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            maxLines: 2),
      ),
    );
  }
}

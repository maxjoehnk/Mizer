import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.dart';
import 'package:mizer/widgets/panel.dart';
import 'package:provider/provider.dart';

import 'cue_contents.dart';
import 'cue_list.dart';
import 'sequence_list.dart';

class SequencerView extends StatefulWidget {
  const SequencerView({Key key}) : super(key: key);

  @override
  State<SequencerView> createState() => _SequencerViewState();
}

class _SequencerViewState extends State<SequencerView> {
  Sequence _sequence;
  Cue _cue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Panel(
            label: "Sequences",
            child: SequenceList(selectSequence: _selectSequence, selectedSequence: _sequence),
            actions: [PanelAction(label: "Add", onClick: () => _addSequence())],
          ),
        ),
        if (_sequence != null)
          Expanded(
            child: Panel(
              label: "Cue List - ${_sequence.name}",
              child: CueList(sequence: _sequence, onSelectCue: _selectCue, selectedCue: _cue),
              actions: [
                PanelAction(label: "Go", onClick: () => _sequenceGo()),
              ],
            ),
          ),
        if (_cue != null)
          Expanded(
              child: Panel(label: "Cue Contents - ${_cue.name}", child: CueContents(cue: _cue)))
      ],
    );
  }

  _addSequence() {}

  _sequenceGo() {
    context.read<SequencerApi>().sequenceGo(_sequence.id);
  }

  _selectSequence(Sequence sequence) {
    setState(() {
      _sequence = sequence;
      _cue = null;
    });
  }

  _selectCue(Cue cue) {
    setState(() => _cue = cue);
  }
}

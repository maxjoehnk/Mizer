import 'dart:async';

import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/mobile/sequencer.dart';

class SequencerDemoApi extends SequencerRemoteApi {
  late StreamController<SequencerState> _controller;

  List<SequenceState> _sequences = [
    SequenceState(sequence: 1, name: "Sequence 1", rate: 1, active: false),
    SequenceState(sequence: 2, name: "Sequence 2", rate: 1, active: false),
    SequenceState(sequence: 3, name: "Sequence 3", rate: 1, active: false),
  ];
  
  SequencerDemoApi() {
    _controller = StreamController.broadcast(onListen: () {
      _controller.add(SequencerState(sequences: _sequences));
    });
  }

  @override
  Stream<SequencerState> getSequencerState() {
    return _controller.stream;
  }

  @override
  Future<void> sequenceGoForward(int sequenceId) async {
    SequenceState sequenceState = _sequences[sequenceId - 1];

    _sequences[sequenceId - 1] = SequenceState(
      sequence: sequenceId,
      name: sequenceState.name,
      rate: 1,
      active: true,
    );

    _controller.add(SequencerState(sequences: _sequences));
  }

  @override
  Future<void> sequenceStop(int sequenceId) async {
    SequenceState sequenceState = _sequences[sequenceId - 1];

    _sequences[sequenceId - 1] = SequenceState(
      sequence: sequenceId,
      name: sequenceState.name,
      rate: 1,
      active: false,
    );

    _controller.add(SequencerState(sequences: _sequences));
  }
}

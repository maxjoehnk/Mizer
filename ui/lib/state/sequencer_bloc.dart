import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/sequencer.dart';

abstract class SequencerCommand {}

class FetchSequences extends SequencerCommand {}

class AddSequence extends SequencerCommand {}

class DeleteSequence extends SequencerCommand {
  int id;

  DeleteSequence(this.id);
}

class UpdateCueTrigger extends SequencerCommand {
  int sequence;
  int cue;
  CueTrigger trigger;

  UpdateCueTrigger({ required this.sequence, required this.cue, required this.trigger });
}

class SelectSequence extends SequencerCommand {
  int sequence;

  SelectSequence({ required this.sequence });
}

class SelectCue extends SequencerCommand {
  int cue;

  SelectCue({ required this.cue });
}

class SequencerState {
  List<Sequence> sequences;
  int? selectedSequenceId;
  int? selectedCueId;
  
  SequencerState({ required this.sequences, this.selectedSequenceId, this.selectedCueId });

  Sequence? get selectedSequence {
    return sequences.firstWhereOrNull((sequence) => sequence.id == selectedSequenceId);
  }

  Cue? get selectedCue {
    return selectedSequence?.cues.firstWhereOrNull((cue) => cue.id == selectedCueId);
  }

  SequencerState copyWith({ List<Sequence>? sequences, int? selectedSequenceId, int? selectedCueId }) {
    if (selectedSequenceId != null) {
      return SequencerState(
        sequences: sequences ?? this.sequences,
        selectedSequenceId: selectedSequenceId,
        selectedCueId: null
      );
    }
    return SequencerState(
      sequences: sequences ?? this.sequences,
      selectedSequenceId: selectedSequenceId ?? this.selectedSequenceId,
      selectedCueId: selectedCueId ?? this.selectedCueId,
    );
  }
}

class SequencerBloc extends Bloc<SequencerCommand, SequencerState> {
  final SequencerApi api;

  SequencerBloc(this.api) : super(SequencerState(sequences: [])) {
    this.add(FetchSequences());
  }

  @override
  Stream<SequencerState> mapEventToState(SequencerCommand event) async* {
    if (event is FetchSequences) {
      yield await _fetchSequences();
    }
    if (event is AddSequence) {
      yield await _addSequence(event);
    }
    if (event is DeleteSequence) {
      yield await _deleteSequence(event);
    }
    if (event is UpdateCueTrigger) {
      yield await _updateCueTrigger(event);
    }
    if (event is SelectSequence) {
      yield _selectSequence(event);
    }
    if (event is SelectCue) {
      yield _selectCue(event);
    }
  }

  Future<SequencerState> _fetchSequences() async {
    log("fetching sequences", name: "SequencerBloc");
    var sequences = await api.getSequences();
    _sortSequences(sequences);
    log("got ${sequences.sequences.length} sequences", name: "SequencerBloc");

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _addSequence(AddSequence event) async {
    log("adding sequence", name: "SequencerBloc");
    await api.addSequence();

    return await _fetchSequences();
  }

  Future<SequencerState> _deleteSequence(DeleteSequence event) async {
    log("deleting sequence", name: "SequencerBloc");
    var sequences = await api.deleteSequence(event.id);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateCueTrigger(UpdateCueTrigger event) async {
    log("update cue trigger ${event.sequence}.${event.cue} ${event.trigger}", name: "SequencerBloc");
    var sequences = await api.updateCueTrigger(event.sequence, event.cue, event.trigger);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  SequencerState _selectSequence(SelectSequence event) {
    return state.copyWith(selectedSequenceId: event.sequence, selectedCueId: null);
  }

  SequencerState _selectCue(SelectCue event) {
    return state.copyWith(selectedCueId: event.cue);
  }

  void _sortSequences(Sequences sequences) {
    sequences.sequences.sort((lhs, rhs) => lhs.id - rhs.id);
  }
}

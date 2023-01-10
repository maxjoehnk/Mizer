import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:mizer/api/contracts/sequencer.dart';

@immutable
abstract class SequencerCommand {}

class FetchSequences extends SequencerCommand {}

class AddSequence extends SequencerCommand {}

class DeleteSequence extends SequencerCommand {
  final int id;

  DeleteSequence(this.id);
}

class DuplicateSequence extends SequencerCommand {
  final int id;

  DuplicateSequence(this.id);
}

class UpdateCueTrigger extends SequencerCommand {
  final int sequence;
  final int cue;
  final CueTrigger_Type trigger;

  UpdateCueTrigger({ required this.sequence, required this.cue, required this.trigger });
}

class UpdateCueTriggerTime extends SequencerCommand {
  final int sequence;
  final int cue;
  final CueTime? time;

  UpdateCueTriggerTime({ required this.sequence, required this.cue, required this.time });
}

class UpdateCueName extends SequencerCommand {
  final int sequence;
  final int cue;
  final String name;

  UpdateCueName({ required this.sequence, required this.cue, required this.name });
}

class UpdateCueFade extends SequencerCommand {
  final int cue;
  final CueTimer? time;

  UpdateCueFade({ required this.cue, this.time });
}

class UpdateCueDelay extends SequencerCommand {
  final int cue;
  final CueTimer? time;

  UpdateCueDelay({ required this.cue, this.time });
}

class UpdateSequenceName extends SequencerCommand {
  final int sequence;
  final String name;

  UpdateSequenceName({ required this.sequence, required this.name });
}

class UpdateWrapAround extends SequencerCommand {
  final int sequence;
  final bool wrapAround;

  UpdateWrapAround({ required this.sequence, required this.wrapAround });
}

class UpdateStopOnLastCue extends SequencerCommand {
  final int sequence;
  final bool stopOnLastCue;

  UpdateStopOnLastCue({ required this.sequence, required this.stopOnLastCue });
}

class SelectSequence extends SequencerCommand {
  final int sequence;

  SelectSequence({ required this.sequence });
}

class SelectCue extends SequencerCommand {
  final int cue;

  SelectCue({ required this.cue });
}

@immutable
class SequencerState {
  final List<Sequence> sequences;
  final int? selectedSequenceId;
  final int? selectedCueId;
  
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
    on<FetchSequences>((event, emit) async => emit(await _fetchSequences()));
    on<AddSequence>((event, emit) async => emit(await _addSequence(event)));
    on<DeleteSequence>((event, emit) async => emit(await _deleteSequence(event)));
    on<UpdateCueTrigger>((event, emit) async => emit(await _updateCueTrigger(event)));
    on<UpdateCueTriggerTime>((event, emit) async => emit(await _updateCueTriggerTime(event)));
    on<UpdateCueName>((event, emit) async => emit(await _updateCueName(event)));
    on<UpdateCueFade>((event, emit) async => emit(await _updateCueFadeTime(event)));
    on<UpdateCueDelay>((event, emit) async => emit(await _updateCueDelayTime(event)));
    on<UpdateWrapAround>((event, emit) async => emit(await _updateSequenceWrapAround(event)));
    on<UpdateStopOnLastCue>((event, emit) async => emit(await _updateSequenceStopOnLastCue(event)));
    on<UpdateSequenceName>((event, emit) async => emit(await _updateSequenceName(event)));
    on<SelectSequence>((event, emit) => emit(_selectSequence(event)));
    on<SelectCue>((event, emit) => emit(_selectCue(event)));
    on<DuplicateSequence>((event, emit) async => emit(await _duplicateSequence(event)));
    this.add(FetchSequences());
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

  Future<SequencerState> _duplicateSequence(DuplicateSequence event) async {
    log("duplicating sequence", name: "SequencerBloc");
    await api.duplicateSequence(event.id);

    return await _fetchSequences();
  }

  Future<SequencerState> _updateCueTrigger(UpdateCueTrigger event) async {
    log("update cue trigger ${event.sequence}.${event.cue} ${event.trigger}", name: "SequencerBloc");
    var sequences = await api.updateCueTrigger(event.sequence, event.cue, event.trigger);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateCueTriggerTime(UpdateCueTriggerTime event) async {
    log("update cue trigger time ${event.sequence}.${event.cue} ${event.time}", name: "SequencerBloc");
    var sequences = await api.updateCueTriggerTime(event.sequence, event.cue, event.time);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateCueName(UpdateCueName event) async {
    log("update cue name ${event.sequence}.${event.cue} ${event.name}", name: "SequencerBloc");
    var sequences = await api.updateCueName(event.sequence, event.cue, event.name);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateSequenceWrapAround(UpdateWrapAround event) async {
    log("update sequence wrap around ${event.sequence} ${event.wrapAround}", name: "SequencerBloc");
    var sequences = await api.updateWrapAround(event.sequence, event.wrapAround);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateSequenceStopOnLastCue(UpdateStopOnLastCue event) async {
    log("update sequence stop on last cue ${event.sequence} ${event.stopOnLastCue}", name: "SequencerBloc");
    var sequences = await api.updateStopOnLastCue(event.sequence, event.stopOnLastCue);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateSequenceName(UpdateSequenceName event) async {
    log("update sequence name ${event.sequence} ${event.name}", name: "SequencerBloc");
    var sequences = await api.updateSequenceName(event.sequence, event.name);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateCueFadeTime(UpdateCueFade event) async {
    log("update cue fade ${state.selectedSequenceId} ${event.cue} ${event.time}", name: "SequencerBloc");
    var sequences = await api.updateCueFadeTime(state.selectedSequenceId!, event.cue, event.time);
    _sortSequences(sequences);

    return state.copyWith(sequences: sequences.sequences);
  }

  Future<SequencerState> _updateCueDelayTime(UpdateCueDelay event) async {
    log("update cue fade ${state.selectedSequenceId} ${event.cue} ${event.time}", name: "SequencerBloc");
    var sequences = await api.updateCueDelayTime(state.selectedSequenceId!, event.cue, event.time);
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

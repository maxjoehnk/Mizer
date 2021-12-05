import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/sequencer.dart';

abstract class SequencerCommand {}

class FetchSequences extends SequencerCommand {}

class AddSequence extends SequencerCommand {}

class DeleteSequence extends SequencerCommand {
  int id;

  DeleteSequence(this.id);
}

class SequencerBloc extends Bloc<SequencerCommand, Sequences> {
  final SequencerApi api;

  SequencerBloc(this.api) : super(Sequences()) {
    this.add(FetchSequences());
  }

  @override
  Stream<Sequences> mapEventToState(SequencerCommand event) async* {
    if (event is FetchSequences) {
      yield await _fetchSequences();
    }
    if (event is AddSequence) {
      yield await _addSequence(event);
    }
    if (event is DeleteSequence) {
      yield await _deleteSequence(event);
    }
  }

  Future<Sequences> _fetchSequences() async {
    log("fetching sequences", name: "SequencerBloc");
    var sequences = await api.getSequences();
    _sortSequences(sequences);
    log("got ${sequences.sequences.length} sequences", name: "SequencerBloc");

    return sequences;
  }

  Future<Sequences> _addSequence(AddSequence event) async {
    log("adding sequence", name: "SequencerBloc");
    await api.addSequence();

    return await _fetchSequences();
  }

  Future<Sequences> _deleteSequence(DeleteSequence event) async {
    log("deleting sequence", name: "SequencerBloc");
    var sequences = await api.deleteSequence(event.id);
    _sortSequences(sequences);

    return sequences;
  }

  void _sortSequences(Sequences sequences) {
    sequences.sequences.sort((lhs, rhs) => lhs.id - rhs.id);
  }
}

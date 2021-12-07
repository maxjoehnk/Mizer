import 'package:mizer/protos/sequencer.pb.dart';

export 'package:mizer/protos/sequencer.pb.dart';

abstract class SequencerApi {
  Future<Sequences> getSequences();

  Future<Sequence> getSequence(int sequenceId);

  Future<Sequence> addSequence();

  Future<void> sequenceGo(int sequence);

  Future<Sequences> deleteSequence(int sequence);

  Future<Sequences> updateCueTrigger(int sequence, int cue, CueTrigger trigger);
}

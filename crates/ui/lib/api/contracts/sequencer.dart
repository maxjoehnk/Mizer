import 'package:mizer/protos/sequencer.pb.dart';

import '../plugin/ffi/sequencer.dart';

export 'package:mizer/protos/sequencer.pb.dart';

abstract class SequencerApi {
  Future<Sequences> getSequences();

  Future<Sequence> getSequence(int sequenceId);

  Future<Sequence> addSequence();
  Future<Sequence> duplicateSequence(int sequence);

  Future<void> sequenceGoForward(int sequence);
  Future<void> sequenceGoBackward(int sequence);
  Future<void> sequenceStop(int sequence);

  Future<Sequences> deleteSequence(int sequence);

  Future<Sequences> updateCueTrigger(int sequence, int cue, CueTrigger_Type trigger);
  Future<Sequences> updateCueTriggerTime(int sequence, int cue, CueTime? time);
  Future<Sequences> updateCueEffectOffsetTime(int sequence, int cue, int effect, double? time);
  Future<Sequences> updateCueName(int sequence, int cue, String name);
  Future<Sequences> updateCueValue(int sequenceId, int cueId, int controlIndex, CueValue value);
  Future<Sequences> updateCueFadeTime(int sequenceId, int cueId, CueTimer? timer);
  Future<Sequences> updateCueDelayTime(int sequenceId, int cueId, CueTimer? timer);

  Future<Sequences> updateWrapAround(int sequence, bool wrapAround);
  Future<Sequences> updateStopOnLastCue(int sequence, bool stopOnLastCue);
  Future<Sequences> updateSequenceName(int sequence, String name);
  Future<Sequences> updatePriority(int sequence, FixturePriority priority);

  Future<SequencerPointer?> getSequencerPointer();
}

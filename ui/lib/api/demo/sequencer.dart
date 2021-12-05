import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.pb.dart';

class SequencerDemoApi implements SequencerApi {
  @override
  Future<Sequences> getSequences() async {
    return Sequences(sequences: [
      Sequence(name: "Sequence 1", cues: [
        Cue(name: "Cue 1", trigger: CueTrigger.GO, loop: false),

      ])
    ]);
  }

  @override
  Future<Sequence> addSequence() {
    // TODO: implement addSequence
    throw UnimplementedError();
  }

  @override
  Future<void> sequenceGo(int sequence) {
    // TODO: implement sequenceGo
    throw UnimplementedError();
  }

  @override
  Future<Sequence> getSequence(int sequenceId) {
    // TODO: implement getSequence
    throw UnimplementedError();
  }
}

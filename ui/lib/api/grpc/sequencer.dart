import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/protos/sequencer.pbgrpc.dart';

class SequencerGrpcApi implements SequencerApi {
  final SequencerApiClient client;

  SequencerGrpcApi(ClientChannel channel) : client = SequencerApiClient(channel);

  @override
  Future<Sequences> getSequences() {
    return this.client.getSequences(GetSequencesRequest());
  }

  @override
  Future<Sequence> addSequence() {
    return this.client.addSequence(AddSequenceRequest());
  }

  @override
  Future<void> sequenceGoForward(int sequence) {
    return this.client.sequenceGo(SequenceGoRequest(sequence: sequence));
  }

  @override
  Future<void> sequenceStop(int sequence) {
    return this.client.sequenceStop(SequenceStopRequest(sequence: sequence));
  }

  @override
  Future<Sequence> getSequence(int sequenceId) {
    return this.client.getSequence(GetSequenceRequest(sequence: sequenceId));
  }

  @override
  Future<Sequences> deleteSequence(int sequenceId) {
    return this.client.deleteSequence(DeleteSequenceRequest(sequence: sequenceId));
  }

  @override
  Future<Sequences> updateCueTrigger(int sequence, int cue, CueTrigger_Type trigger) {
    return this.client.updateCueTrigger(CueTriggerRequest(sequence: sequence, cue: cue, trigger: trigger));
  }

  @override
  Future<SequencerPointer?> getSequencerPointer() async {
    return null;
  }

  @override
  Future<Sequences> updateCueName(int sequence, int cue, String name) {
    return this.client.updateCueName(CueNameRequest(sequence: sequence, cue: cue, name: name));
  }

  @override
  Future<Sequences> updateCueValue(int sequenceId, int cueId, int controlIndex, CueValue value) {
    return this.client.updateCueValue(CueValueRequest(sequenceId: sequenceId, cueId: cueId, controlIndex: controlIndex, value: value));
  }

  @override
  Future<Sequences> updateCueFadeTime(int sequenceId, int cueId, CueTimer? value) {
    return this.client.updateCueFadeTime(CueTimingRequest(sequenceId: sequenceId, cueId: cueId, time: value));
  }

  @override
  Future<Sequences> updateCueDelayTime(int sequenceId, int cueId, CueTimer? value) {
    return this.client.updateCueDelayTime(CueTimingRequest(sequenceId: sequenceId, cueId: cueId, time: value));
  }

  @override
  Future<Sequences> updateSequenceName(int sequence, String name) {
    return this.client.updateSequenceName(CueNameRequest(sequence: sequence, name: name));
  }

  @override
  Future<Sequences> updateWrapAround(int sequence, bool wrapAround) {
    return this.client.updateSequenceWrapAround(SequenceWrapAroundRequest(sequence: sequence, wrapAround: wrapAround));
  }
}

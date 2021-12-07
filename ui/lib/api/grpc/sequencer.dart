import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
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
  Future<void> sequenceGo(int sequence) {
    return this.client.sequenceGo(SequenceGoRequest(sequence: sequence));
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
  Future<Sequences> updateCueTrigger(int sequence, int cue, CueTrigger trigger) {
    return this.client.updateCueTrigger(CueTriggerRequest(sequence: sequence, cue: cue, trigger: trigger));
  }
}

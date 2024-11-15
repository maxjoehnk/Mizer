import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/sequencer.dart';
import 'package:mizer/protos/sequencer.pbgrpc.dart';

export 'package:mizer/protos/sequencer.pbgrpc.dart' show SequenceState, SequencerState;

class SequencerMobileApi implements SequencerRemoteApi {
  final SequencerRemoteApiClient _client;

  SequencerMobileApi(ClientChannel channel) : _client = SequencerRemoteApiClient(channel);

  @override
  Stream<SequencerState> getSequencerState() {
    return _client.subscribeToSequences(GetSequencesRequest());
  }

  @override
  Future<void> sequenceGoForward(int sequence) {
  return _client.goSequence(SequenceGoRequest(sequence: sequence));
  }

  @override
  Future<void> sequenceStop(int sequence) {
    return _client.stopSequence(SequenceStopRequest(sequence: sequence));
  }
}

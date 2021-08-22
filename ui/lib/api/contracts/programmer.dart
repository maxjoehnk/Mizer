import 'package:mizer/protos/programmer.pb.dart';

export 'package:mizer/protos/programmer.pb.dart';

abstract class ProgrammerApi {
  Future<void> writeChannels(WriteChannelsRequest request);

  Future<void> selectFixtures(List<int> fixtureIds);

  Future<void> clear();

  Future<void> highlight(bool highlight);

  Future<void> store(int sequenceId, StoreRequest_Mode storeMode);

  Stream<ProgrammerState> observe();
}

import 'package:mizer/protos/programmer.pb.dart';

export 'package:mizer/protos/programmer.pb.dart';

abstract class ProgrammerApi {
  Future<void> writeChannels(WriteChannelsRequest request);

  Future<void> selectFixtures(List<int> fixtureIds);

  Future<void> clear();

  Future<void> highlight(bool highlight);

  Stream<ProgrammerState> observe();
}

import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/programmer.pb.dart';

export 'package:mizer/protos/programmer.pb.dart';

abstract class ProgrammerApi {
  Future<void> writeControl(WriteControlRequest request);

  Future<void> selectFixtures(List<FixtureId> fixtureIds);

  Future<void> clear();

  Future<void> highlight(bool highlight);

  Future<void> store(int sequenceId, StoreRequest_Mode storeMode);

  Stream<ProgrammerState> observe();

  Future<Presets> getPresets();

  Future<void> callPreset(PresetId id);

  Future<Groups> getGroups();

  Future<void> selectGroup(int id);
}

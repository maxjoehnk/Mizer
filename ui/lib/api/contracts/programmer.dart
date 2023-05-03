import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/programmer.pb.dart';

import '../plugin/ffi/programmer.dart';

export 'package:mizer/protos/programmer.pb.dart';

abstract class ProgrammerApi {
  Future<void> writeControl(WriteControlRequest request);

  Future<void> selectFixtures(List<FixtureId> fixtureIds);
  Future<void> unselectFixtures(List<FixtureId> fixtureIds);

  Future<void> clear();

  Future<void> highlight(bool highlight);

  Future<void> store(int sequenceId, StoreRequest_Mode storeMode, {int? cueId});

  Stream<ProgrammerState> observe();

  Future<Presets> getPresets();

  Future<void> callPreset(PresetId id);

  Future<void> callEffect(int id);

  Future<Groups> getGroups();

  Future<void> selectGroup(int id);

  Future<Group> addGroup(String name);

  Future<void> assignFixturesToGroup(List<FixtureId> fixtures, Group group);

  Future<void> assignFixtureSelectionToGroup(Group group);

  Future<ProgrammerStatePointer?> getProgrammerPointer();

  Future<void> updateBlockSize(int blockSize);
  Future<void> updateGroups(int groups);
  Future<void> updateWings(int wings);

  Future<void> next();
  Future<void> prev();
  Future<void> set();
  Future<void> shuffle();

  Future<void> writeEffectRate(int effectId, double effectRate);
  Future<void> writeEffectOffset(int effectId, double? effectOffset);
}

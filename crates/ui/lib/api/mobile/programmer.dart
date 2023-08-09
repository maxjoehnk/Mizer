import 'package:grpc/grpc.dart';
import 'package:mizer/api/plugin/ffi/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/programmer.pbgrpc.dart';

import '../contracts/programmer.dart';

class ProgrammerMobileApi extends ProgrammerApi {
  final ProgrammerApiClient _client;

  ProgrammerMobileApi(ClientChannel channel) : _client = ProgrammerApiClient(channel);

  @override
  Future<Group> addGroup(String name) {
    // TODO: implement addGroup
    throw UnimplementedError();
  }

  @override
  Future<void> assignFixtureSelectionToGroup(Group group) {
    // TODO: implement assignFixtureSelectionToGroup
    throw UnimplementedError();
  }

  @override
  Future<void> assignFixturesToGroup(List<FixtureId> fixtures, Group group) {
    // TODO: implement assignFixturesToGroup
    throw UnimplementedError();
  }

  @override
  Future<void> callEffect(int id) {
    // TODO: implement callEffect
    throw UnimplementedError();
  }

  @override
  Future<void> callPreset(PresetId id) {
    // TODO: implement callPreset
    throw UnimplementedError();
  }

  @override
  Future<void> clear() async {
    await _client.clear(ClearRequest());
  }

  @override
  Future<void> deleteGroup(int id) {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

  @override
  Future<void> deletePreset(PresetId id) {
    // TODO: implement deletePreset
    throw UnimplementedError();
  }

  @override
  Future<Groups> getGroups() {
    // TODO: implement getGroups
    throw UnimplementedError();
  }

  @override
  Future<Presets> getPresets() {
    // TODO: implement getPresets
    throw UnimplementedError();
  }

  @override
  Future<ProgrammerStatePointer?> getProgrammerPointer() {
    // TODO: implement getProgrammerPointer
    throw UnimplementedError();
  }

  @override
  Future<void> highlight(bool highlight) async {
    await _client.highlight(HighlightRequest()..highlight = highlight);
  }

  @override
  Future<void> next() {
    // TODO: implement next
    throw UnimplementedError();
  }

  @override
  Stream<ProgrammerState> observe() {
    return this._client.subscribeToProgrammer(SubscribeProgrammerRequest());
  }

  @override
  Future<void> prev() {
    // TODO: implement prev
    throw UnimplementedError();
  }

  @override
  Future<void> renameGroup(int id, String name) {
    // TODO: implement renameGroup
    throw UnimplementedError();
  }

  @override
  Future<void> renamePreset(PresetId id, String name) {
    // TODO: implement renamePreset
    throw UnimplementedError();
  }

  @override
  Future<void> selectFixtures(List<FixtureId> fixtureIds) async {
    await _client.selectFixtures(SelectFixturesRequest()..fixtures.addAll(fixtureIds));
  }

  @override
  Future<void> selectGroup(int id) {
    // TODO: implement selectGroup
    throw UnimplementedError();
  }

  @override
  Future<void> set() {
    // TODO: implement set
    throw UnimplementedError();
  }

  @override
  Future<void> shuffle() {
    // TODO: implement shuffle
    throw UnimplementedError();
  }

  @override
  Future<void> store(int sequenceId, StoreRequest_Mode storeMode, {int? cueId}) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future<void> storePreset(StorePresetRequest request) {
    // TODO: implement storePreset
    throw UnimplementedError();
  }

  @override
  Future<void> unselectFixtures(List<FixtureId> fixtureIds) async {
    await _client.unselectFixtures(UnselectFixturesRequest()..fixtures.addAll(fixtureIds));
  }

  @override
  Future<void> updateBlockSize(int blockSize) {
    // TODO: implement updateBlockSize
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroups(int groups) {
    // TODO: implement updateGroups
    throw UnimplementedError();
  }

  @override
  Future<void> updateWings(int wings) {
    // TODO: implement updateWings
    throw UnimplementedError();
  }

  @override
  Future<void> writeControl(WriteControlRequest request) {
    // TODO: implement writeControl
    throw UnimplementedError();
  }

  @override
  Future<void> writeEffectOffset(int effectId, double? effectOffset) {
    // TODO: implement writeEffectOffset
    throw UnimplementedError();
  }

  @override
  Future<void> writeEffectRate(int effectId, double effectRate) {
    // TODO: implement writeEffectRate
    throw UnimplementedError();
  }
}

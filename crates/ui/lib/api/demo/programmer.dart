import 'dart:async';

import 'package:mizer/api/plugin/ffi/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import '../contracts/programmer.dart';

class ProgrammerDemoApi extends ProgrammerApi {
  StreamController<ProgrammerState> _controller = StreamController.broadcast();
  bool _highlight = false;
  List<FixtureId> _selection = [];

  void _emit() {
    _controller.add(ProgrammerState(highlight: _highlight, activeFixtures: _selection));
  }

  @override
  Future<Group> addGroup(String name) {
    // TODO: implement addGroup
    throw UnimplementedError();
  }

  @override
  Future<void> assignFixtureSelectionToGroup(Group group, StoreGroupMode mode) {
    // TODO: implement assignFixtureSelectionToGroup
    throw UnimplementedError();
  }

  @override
  Future<void> assignFixturesToGroup(List<FixtureId> fixtures, Group group, StoreGroupMode mode) {
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
    _selection = [];
    _emit();
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
    _highlight = highlight;
    _emit();
  }

  @override
  Future<void> next() async {
  }

  @override
  Stream<ProgrammerState> observe() {
    return _controller.stream;
  }

  @override
  Future<void> prev() async {
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
    _selection.addAll(fixtureIds);
    _selection = _selection.toSet().toList();
    _emit();
  }

  @override
  Future<void> selectGroup(int id) {
    // TODO: implement selectGroup
    throw UnimplementedError();
  }

  @override
  Future<void> set() async {
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
    _selection = _selection.where((element) => !fixtureIds.contains(element)).toList();
    _emit();
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

  @override
  Future<void> setOffline(bool offline) {
    // TODO: implement setOffline
    throw UnimplementedError();
  }
}

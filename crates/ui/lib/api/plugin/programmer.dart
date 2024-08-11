import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/api/plugin/ffi/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';

export 'ffi/programmer.dart' show ProgrammerStatePointer;

class ProgrammerPluginApi implements ProgrammerApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/programmer");
  final EventChannel stateEvents = const EventChannel("mizer.live/programmer/watch");

  ProgrammerPluginApi(this.bindings);

  @override
  Future<void> writeControl(WriteControlRequest request) async {
    await channel.invokeMethod("writeControl", request.writeToBuffer());
  }

  @override
  Future<void> selectFixtures(List<FixtureId> fixtureIds) async {
    await channel.invokeMethod(
        "selectFixtures", SelectFixturesRequest(fixtures: fixtureIds).writeToBuffer());
  }

  @override
  Future<void> unselectFixtures(List<FixtureId> fixtureIds) async {
    await channel.invokeMethod(
        "unselectFixtures", UnselectFixturesRequest(fixtures: fixtureIds).writeToBuffer());
  }

  @override
  Future<void> clear() async {
    await channel.invokeMethod("clear");
  }

  @override
  Future<void> highlight(bool highlight) async {
    await channel.invokeMethod("highlight", highlight);
  }

  @override
  Future<void> store(int sequenceId, StoreRequest_Mode storeMode, {int? cueId}) async {
    var request = StoreRequest(sequenceId: sequenceId, storeMode: storeMode, cueId: cueId);
    await channel.invokeMethod("store", request.writeToBuffer());
  }

  @override
  Stream<ProgrammerState> observe() {
    return stateEvents.receiveBroadcastStream().map((buffer) {
      log("$buffer");
      return ProgrammerState.fromBuffer(_convertBuffer(buffer));
    }).map((state) {
      log("$state");
      return state;
    });
  }

  @override
  Future<Presets> getPresets() async {
    var response = await channel.invokeMethod("getPresets");

    return Presets.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> callPreset(PresetId id) async {
    await channel.invokeMethod("callPreset", id.writeToBuffer());
  }

  @override
  Future<Groups> getGroups() async {
    var response = await channel.invokeMethod("getGroups");

    return Groups.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> selectGroup(int id) async {
    await channel.invokeMethod("selectGroup", id);
  }

  Future<ProgrammerStatePointer?> getProgrammerPointer() async {
    int pointer = await channel.invokeMethod("getProgrammerPointer");

    return this.bindings.openProgrammer(pointer);
  }

  @override
  Future<Group> addGroup(String name) async {
    var response = await channel.invokeMethod("addGroup", name);

    return Group.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> deleteGroup(int id) async {
    await channel.invokeMethod("deleteGroup", id);
  }

  @override
  Future<void> renameGroup(int id, String name) async {
    var req = RenameGroupRequest(id: id, name: name);
    await channel.invokeMethod("renameGroup", req.writeToBuffer());
  }

  @override
  Future<void> assignFixturesToGroup(List<FixtureId> fixtures, Group group, StoreGroupMode mode) async {
    var request = AssignFixturesToGroupRequest(id: group.id, fixtures: fixtures, mode: mode);
    await channel.invokeMethod("assignFixturesToGroup", request.writeToBuffer());
  }

  @override
  Future<void> assignFixtureSelectionToGroup(Group group, StoreGroupMode mode) async {
    var req = AssignFixtureSelectionToGroupRequest(id: group.id, mode: mode);

    await channel.invokeMethod("assignFixtureSelectionToGroup", req.writeToBuffer());
  }

  @override
  Future<void> callEffect(int id) async {
    await channel.invokeMethod("callEffect", id);
  }

  @override
  Future<void> updateBlockSize(int blockSize) async {
    await channel.invokeMethod("updateBlockSize", blockSize);
  }

  @override
  Future<void> updateGroups(int groups) async {
    await channel.invokeMethod("updateGroups", groups);
  }

  @override
  Future<void> updateWings(int wings) async {
    await channel.invokeMethod("updateWings", wings);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<void> next() async {
    await channel.invokeMethod("next");
  }

  @override
  Future<void> prev() async {
    await channel.invokeMethod("prev");
  }

  @override
  Future<void> set() async {
    await channel.invokeMethod("set");
  }

  @override
  Future<void> shuffle() async {
    await channel.invokeMethod("shuffle");
  }

  @override
  Future<void> writeEffectOffset(int effectId, double? effectOffset) async {
    var request = WriteEffectOffsetRequest(effectId: effectId, effectOffset: effectOffset);
    await channel.invokeMethod("writeEffectOffset", request.writeToBuffer());
  }

  @override
  Future<void> writeEffectRate(int effectId, double effectRate) async {
    var request = WriteEffectRateRequest(effectId: effectId, effectRate: effectRate);
    await channel.invokeMethod("writeEffectRate", request.writeToBuffer());
  }

  @override
  Future<void> storePreset(StorePresetRequest request) async {
    await channel.invokeMethod("storePreset", request.writeToBuffer());
  }

  @override
  Future<void> deletePreset(PresetId id) async {
    await channel.invokeMethod("deletePreset", id.writeToBuffer());
  }

  @override
  Future<void> renamePreset(PresetId id, String name) async {
    var req = RenamePresetRequest(id: id, label: name);
    await channel.invokeMethod("renamePreset", req.writeToBuffer());
  }

  @override
  Future<void> setOffline(bool offline) {
    if (offline) {
      return channel.invokeMethod("markOffline");
    } else {
      return channel.invokeMethod("markOnline");
    }
  }
}

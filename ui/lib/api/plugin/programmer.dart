import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';

class ProgrammerPluginApi implements ProgrammerApi {
  final MethodChannel channel = const MethodChannel("mizer.live/programmer");
  final EventChannel stateEvents = const EventChannel("mizer.live/programmer/watch");

  @override
  Future<void> writeControl(WriteControlRequest request) async {
    await channel.invokeMethod("writeControl", request.writeToBuffer());
  }

  @override
  Future<void> selectFixtures(List<FixtureId> fixtureIds) async {
    await channel.invokeMethod("selectFixtures", SelectFixturesRequest(fixtures: fixtureIds).writeToBuffer());
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
  Future<void> store(int sequenceId, StoreRequest_Mode storeMode) async {
    var request = StoreRequest(sequenceId: sequenceId, storeMode: storeMode);
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

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}

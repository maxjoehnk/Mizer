import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/programmer.pb.dart';

class ProgrammerPluginApi implements ProgrammerApi {
  final MethodChannel channel = const MethodChannel("mizer.live/programmer");
  final EventChannel stateEvents = const EventChannel("mizer.live/");

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
    return stateEvents
        .receiveBroadcastStream()
        .map((buffer) => ProgrammerState.fromBuffer(_convertBuffer(buffer)));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}

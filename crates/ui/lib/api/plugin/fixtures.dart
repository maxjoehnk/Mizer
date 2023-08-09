import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';

class FixturesPluginApi implements FixturesApi {
  final MethodChannel channel = const MethodChannel("mizer.live/fixtures");

  @override
  Future<Fixtures> addFixtures(AddFixturesRequest request) async {
    var response = await channel.invokeMethod("addFixtures", request.writeToBuffer());

    return _parseResponse(response);
  }

  @override
  Future<FixtureDefinitions> getFixtureDefinitions() async {
    var response = await channel.invokeMethod("getFixtureDefinitions");

    return FixtureDefinitions.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Fixtures> getFixtures() async {
    var response = await channel.invokeMethod("getFixtures");

    return _parseResponse(response);
  }

  @override
  Future<Fixtures> deleteFixtures(List<int> fixtureIds) async {
    var response = await channel.invokeMethod("deleteFixtures", fixtureIds);

    return _parseResponse(response);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  static Fixtures _parseResponse(List<Object> response) {
    return Fixtures.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> updateFixture(int fixtureId, UpdateFixtureRequest request) async {
    request.fixtureId = fixtureId;
    await channel.invokeMethod("updateFixture", request.writeToBuffer());
  }

  @override
  Future<void> exportPatch(String path) async {
    await channel.invokeMethod("exportPatch", path);
  }
}

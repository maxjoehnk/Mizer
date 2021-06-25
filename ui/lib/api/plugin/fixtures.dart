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
  Future<Fixtures> writeFixtureChannel(WriteFixtureChannelRequest request) async {
    var response = await channel.invokeMethod("writeFixtureChannel", request.writeToBuffer());

    return _parseResponse(response);
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  static Fixtures _parseResponse(List<Object> response) {
    return Fixtures.fromBuffer(_convertBuffer(response));
  }
}

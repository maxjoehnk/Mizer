import 'package:grpc/grpc.dart';
import 'package:mizer/protos/fixtures.pbgrpc.dart';

import '../contracts/fixtures.dart';

class FixturesMobileApi implements FixturesApi {
  final FixturesApiClient _client;

  FixturesMobileApi(ClientChannel channel) : _client = FixturesApiClient(channel);

  @override
  Future<Fixtures> addFixtures(AddFixturesRequest request) {
    // TODO: implement addFixtures
    throw UnimplementedError();
  }

  @override
  Future<Fixtures> deleteFixtures(List<int> fixtureIds) {
    // TODO: implement deleteFixtures
    throw UnimplementedError();
  }

  @override
  Future<FixtureDefinitions> getFixtureDefinitions() {
    // TODO: implement getFixtureDefinitions
    throw UnimplementedError();
  }

  @override
  Future<Fixtures> getFixtures() {
    return this._client.getFixtures(GetFixturesRequest());
  }

  @override
  Future<void> updateFixture(int fixtureId, UpdateFixtureRequest request) {
    // TODO: implement updateFixture
    throw UnimplementedError();
  }

  @override
  Future<void> exportPatch(String path) {
    // TODO: implement exportPatch
    throw UnimplementedError();
  }

  @override
  Future<Fixtures> previewFixtures(AddFixturesRequest request) {
    // TODO: implement previewFixtures
    throw UnimplementedError();
  }
}

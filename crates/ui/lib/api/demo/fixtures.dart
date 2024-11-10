import 'package:mizer/protos/fixtures.pbgrpc.dart';

import '../contracts/fixtures.dart';

class FixturesDemoApi implements FixturesApi {
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
  Future<Fixtures> getFixtures() async {
    return Fixtures(fixtures: List.generate(10, (index) => Fixture(
      id: index + 1,
      name: 'Fixture ${index + 1}',
      channel: 1 + (index * 10),
      universe: 1,
    )));
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

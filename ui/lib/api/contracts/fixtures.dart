import 'package:mizer/protos/fixtures.pb.dart';

abstract class FixturesApi {
  Future<Fixtures> addFixtures(AddFixturesRequest request);

  Future<Fixtures> getFixtures();

  Future<FixtureDefinitions> getFixtureDefinitions();

  Future<Fixtures> deleteFixtures(List<int> fixtureIds);

  Future<void> updateFixture(int fixtureId, UpdateFixtureRequest request);
}

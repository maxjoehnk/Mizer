import 'package:mizer/protos/fixtures.pb.dart';

abstract class FixturesApi {
  Future<Fixtures> addFixtures(AddFixturesRequest request);

  Future<Fixtures> getFixtures();

  Future<FixtureDefinitions> getFixtureDefinitions();
}

import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';

class FixturesDemoApi implements FixturesApi {
  @override
  Future<Fixtures> addFixtures(AddFixturesRequest request) async {
    return Fixtures();
  }

  @override
  Future<FixtureDefinitions> getFixtureDefinitions() async {
    return FixtureDefinitions();
  }

  @override
  Future<Fixtures> getFixtures() async {
    return Fixtures();
  }
}

import 'package:mizer/protos/fixtures.pb.dart';

extension OverlapExtension on FixtureId {
  bool overlaps(FixtureId id) {
    if (this.hasFixture()) {
      if (id.hasFixture()) {
        return this.fixture == id.fixture;
      }else {
        return this.fixture == id.subFixture.fixtureId;
      }
    }else {
      if (id.hasFixture()) {
        return this.subFixture.fixtureId == id.fixture;
      } else {
        return this == id;
      }
    }
  }
}

import 'package:mizer/protos/fixtures.pb.dart';

extension FixtureIdExtensions on FixtureId {
  String toDisplay() {
    if (this.hasSubFixture()) {
      return "${this.subFixture.fixtureId}:${this.subFixture.childId}";
    }
    return this.fixture.toString();
  }

  int get fixtureId {
    return this.hasSubFixture() ? this.subFixture.fixtureId : this.fixture;
  }
}

class FixtureInstance {
  final Fixture? fixture;
  final SubFixture? subFixture;

  FixtureInstance({ this.fixture, this.subFixture });

  factory FixtureInstance.fixture(Fixture fixture) {
    return new FixtureInstance(fixture: fixture);
  }
  factory FixtureInstance.subFixture(SubFixture subFixture) {
    return new FixtureInstance(subFixture: subFixture);
  }

  String get name {
    return fixture?.name ?? subFixture!.name;
  }

  List<FixtureControls> get controls {
    return subFixture?.controls ?? fixture!.controls;
  }
}

extension FixtureExtension on Fixture {
  FixtureInstance toInstance() {
    return FixtureInstance.fixture(this);
  }
}

extension SubFixtureExtension on SubFixture {
  FixtureInstance toInstance() {
    return FixtureInstance.subFixture(this);
  }
}

extension FixtureListExtensions on List<Fixture> {
  FixtureInstance getFixture(FixtureId id) {
    var fixture = this.firstWhere((f) => f.id == id.fixtureId);
    if (id.hasSubFixture()) {
      var subFixture = fixture.children.firstWhere((c) => c.id == id.subFixture.childId);

      return subFixture.toInstance();
    }

    return fixture.toInstance();
  }
}

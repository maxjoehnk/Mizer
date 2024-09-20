import 'package:collection/collection.dart';
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
  
  int compareTo(FixtureId other) {
    var fixtureIdDiff = this.fixtureId - other.fixtureId;
    if (fixtureIdDiff == 0) {
      if (this.hasSubFixture() && other.hasSubFixture()) {
        return this.subFixture.childId - other.subFixture.childId;
      }
      if (this.hasSubFixture()) {
        return -1;
      }else {
        return 1;
      }
    }
    return fixtureIdDiff;
  }
}

class FixtureInstance {
  final Fixture? fixture;
  final SubFixture? subFixture;
  final FixtureId id;

  FixtureInstance(this.id, { this.fixture, this.subFixture });

  factory FixtureInstance.fixture(FixtureId id, Fixture fixture) {
    return new FixtureInstance(id, fixture: fixture);
  }
  factory FixtureInstance.subFixture(FixtureId id, SubFixture subFixture) {
    return new FixtureInstance(id, subFixture: subFixture);
  }

  String get name {
    return fixture?.name ?? subFixture!.name;
  }

  List<FixtureChannel> get controls {
    return subFixture?.channels ?? fixture!.channels;
  }
}

extension FixtureExtension on Fixture {
  FixtureInstance toInstance(FixtureId id) {
    return FixtureInstance.fixture(id, this);
  }
}

extension SubFixtureExtension on SubFixture {
  FixtureInstance toInstance(FixtureId id) {
    return FixtureInstance.subFixture(id, this);
  }
}

extension FixtureListExtensions on List<Fixture> {
  FixtureInstance? getFixture(FixtureId id) {
    var fixture = this.firstWhereOrNull((f) => f.id == id.fixtureId);
    if (fixture == null) {
      return null;
    }
    if (id.hasSubFixture()) {
      var subFixture = fixture.children.firstWhere((c) => c.id == id.subFixture.childId);

      return subFixture.toInstance(id);
    }

    return fixture.toInstance(id);
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';

abstract class FixturesEvent {}

class FetchFixtures extends FixturesEvent {}

class AddFixtures extends FixturesEvent {
  FixtureDefinition definition;
  FixtureMode mode;
  int universe;
  int count;
  int startId;
  int startChannel;

  AddFixtures({this.definition, this.mode, this.universe, this.count, this.startId, this.startChannel});

  AddFixturesRequest _into() {
    List<AddFixtureRequest> fixtures = [];
    for (var i = 0; i < count; i++) {
      var request = AddFixtureRequest(
          definitionId: definition.id,
          mode: mode.name,
          universe: universe,
          id: startId + i,
          channel: startChannel + (mode.channels.length * i),
      );
      fixtures.add(request);
    }
    return AddFixturesRequest(requests: fixtures);
  }

  @override
  String toString() {
    return 'AddFixtures{definition: $definition, mode: $mode, universe: $universe, count: $count, startId: $startId, startChannel: $startChannel}';
  }
}

class FixturesBloc extends Bloc<FixturesEvent, Fixtures> {
  final FixturesApi api;

  FixturesBloc(this.api) : super(Fixtures()) {
    this.add(FetchFixtures());
  }

  @override
  Stream<Fixtures> mapEventToState(FixturesEvent event) async* {
    if (event is FetchFixtures) {
      yield await _fetchFixtures();
    }
    if (event is AddFixtures) {
      yield await _addFixture(event);
    }
  }

  Future<Fixtures> _fetchFixtures() async {
    log("fetching fixtures", name: "FixturesBloc");
    var fixtures = await api.getFixtures();
    log("got ${fixtures.fixtures.length} fixtures", name: "FixturesBloc");

    return fixtures;
  }

  Future<Fixtures> _addFixture(AddFixtures event) async {
    log("adding fixtures: $event", name: "FixturesBloc");
    var request = event._into();
    var fixtures = await api.addFixtures(request);

    return fixtures;
  }
}

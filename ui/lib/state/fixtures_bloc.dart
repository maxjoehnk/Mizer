import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pb.dart';

abstract class FixturesEvent {}

class FetchFixtures extends FixturesEvent {}

class AddFixtures extends FixturesEvent {
  FixtureDefinition definition;
  FixtureMode mode;
  String name;
  int universe;
  int count;
  int startId;
  int startChannel;

  AddFixtures({required this.definition, required this.name, required this.mode, required this.universe, required this.count, required this.startId, required this.startChannel});

  AddFixturesRequest _into() {
    var request = AddFixtureRequest(
      definitionId: definition.id,
      name: name,
      mode: mode.name,
      universe: universe,
      id: startId,
      channel: startChannel,
    );
    return AddFixturesRequest(request: request, count: count);
  }

  @override
  String toString() {
    return 'AddFixtures{definition: $definition, name: $name, mode: $mode, universe: $universe, count: $count, startId: $startId, startChannel: $startChannel}';
  }
}

class DeleteFixtures extends FixturesEvent {
  List<int> ids;

  DeleteFixtures(this.ids);
}

class UpdateFixture extends FixturesEvent {
  final int fixtureId;
  final UpdateFixtureRequest updateRequest;

  UpdateFixture(this.fixtureId, this.updateRequest);
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
    if (event is DeleteFixtures) {
      yield await _deleteFixtures(event);
    }
    if (event is UpdateFixture) {
      yield await _updateFixture(event);
    }
  }

  Future<Fixtures> _fetchFixtures() async {
    log("fetching fixtures", name: "FixturesBloc");
    Fixtures fixtures = await _getFixtures();
    log("got ${fixtures.fixtures.length} fixtures", name: "FixturesBloc");

    return fixtures;
  }

  Future<Fixtures> _addFixture(AddFixtures event) async {
    log("adding fixtures: $event", name: "FixturesBloc");
    var request = event._into();
    var fixtures = await api.addFixtures(request);

    return fixtures;
  }

  Future<Fixtures> _deleteFixtures(DeleteFixtures event) async {
    log("deleting fixtures: $event", name: "FixturesBloc");
    var fixtures = await api.deleteFixtures(event.ids);

    return fixtures;
  }

  Future<Fixtures> _updateFixture(UpdateFixture event) async {
    log("update fixture: $event", name: "FixturesBloc");
    await api.updateFixture(event.fixtureId, event.updateRequest);

    return await _getFixtures();
  }

  Future<Fixtures> _getFixtures() async {
    var fixtures = await api.getFixtures();

    fixtures.fixtures.sortByCompare<int>((fixture) => fixture.id, (lhs, rhs) => lhs - rhs);
    return fixtures;
  }
}

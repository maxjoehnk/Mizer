import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/fixtures.pbgrpc.dart';

enum FixturesEvent { Fetch }

class FixturesBloc extends Bloc<FixturesEvent, Fixtures> {
  final FixturesApiClient client;

  FixturesBloc(ClientChannel channel)
      : client = FixturesApiClient(channel),
        super(Fixtures.create()) {
    this.add(FixturesEvent.Fetch);
  }

  @override
  Stream<Fixtures> mapEventToState(FixturesEvent event) async* {
    switch (event) {
      case FixturesEvent.Fetch:
        log("fetching fixtures", name: "FixturesBloc");
        yield await client.getFixtures(GetFixturesRequest());
        log("got ${this.state.fixtures.length} fixtures", name: "FixturesBloc");
        break;
    }
  }
}

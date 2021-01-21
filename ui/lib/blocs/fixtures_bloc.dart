import 'package:bloc/bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:ui/protos/fixtures.pb.dart';
import 'package:ui/protos/fixtures.pbgrpc.dart';

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
        yield await client.getFixtures(GetFixturesRequest());
        break;
    }
  }
}

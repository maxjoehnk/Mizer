import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/fixtures.dart';
import 'package:mizer/protos/fixtures.pbgrpc.dart';

class FixturesGrpcApi implements FixturesApi {
  final FixturesApiClient client;
  
  FixturesGrpcApi(ClientChannel channel) : client = FixturesApiClient(channel);

  @override
  Future<Fixtures> addFixtures(AddFixturesRequest request) {
    return client.addFixtures(request);
  }

  @override
  Future<Fixtures> getFixtures() {
    return client.getFixtures(GetFixturesRequest());
  }

  @override
  Future<FixtureDefinitions> getFixtureDefinitions() {
    return client.getFixtureDefinitions(GetFixtureDefinitionsRequest());
  }

  @override
  Future<Fixtures> deleteFixtures(List<int> fixtureIds) {
    return client.deleteFixtures(DeleteFixturesRequest(fixtureIds: fixtureIds));
  }
}

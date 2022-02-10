import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/plans.dart';
import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pbgrpc.dart';

class PlansGrpcApi implements PlansApi {
  final PlansApiClient client;

  PlansGrpcApi(ClientChannel channel) : client = PlansApiClient(channel);

  @override
  Future<void> addFixture(String planId, FixtureId fixtureId) {
    // TODO: implement addFixture
    throw UnimplementedError();
  }

  @override
  Future<void> addPlan(String name) {
    // TODO: implement addPlan
    throw UnimplementedError();
  }

  @override
  Future<Plans> getPlans() {
    return this.client.getPlans(PlansRequest());
  }

  @override
  Future<void> removePlan(String id) {
    // TODO: implement removePlan
    throw UnimplementedError();
  }

  @override
  Future<void> renamePlan(String id, String name) {
    // TODO: implement renamePlan
    throw UnimplementedError();
  }

  @override
  Future<FixturesRefPointer?> getFixturesPointer() async {
    return null;
  }
}

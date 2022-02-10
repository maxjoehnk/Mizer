import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/protos/fixtures.pb.dart';
import 'package:mizer/protos/plans.pb.dart';

abstract class PlansApi {
  Future<Plans> getPlans();
  Future<void> addPlan(String name);
  Future<void> removePlan(String id);
  Future<void> renamePlan(String id, String name);

  Future<void> addFixture(String planId, FixtureId fixtureId);

  Future<FixturesRefPointer?> getFixturesPointer();
}

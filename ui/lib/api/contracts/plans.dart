import 'package:mizer/api/plugin/ffi/plans.dart';
import 'package:mizer/protos/plans.pb.dart';

abstract class PlansApi {
  Future<Plans> getPlans();
  Future<void> addPlan(String name);
  Future<void> removePlan(String id);
  Future<void> renamePlan(String id, String name);

  Future<void> addFixtureSelection(String planId);
  Future<void> moveSelection(String planId, double dx, double dy);
  Future<void> moveFixture(MoveFixtureRequest request);

  Future<FixturesRefPointer?> getFixturesPointer();
}

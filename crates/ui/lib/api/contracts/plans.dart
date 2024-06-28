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
  Future<void> alignFixtures(AlignFixturesRequest request);
  Future<void> transformFixtures(TransformFixturesRequest request);
  Future<void> spreadFixtures(SpreadFixturesRequest request);

  Future<void> addImage(AddImageRequest request);
  Future<void> moveImage(MoveImageRequest request);
  Future<void> resizeImage(ResizeImageRequest request);
  Future<void> removeImage(String planId, String imageId);

  Future<void> addScreen(AddScreenRequest request);

  Future<FixturesRefPointer?> getFixturesPointer();
}

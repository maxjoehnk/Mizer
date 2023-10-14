import 'package:mizer/protos/surfaces.pb.dart';

abstract class SurfacesApi {
  Stream<List<Surface>> getSurfaces();

  Future<void> renameSurface(String surfaceId, String name);
  Future<void> updateSectionInput(String surfaceId, int sectionId, SurfaceTransform input);
  Future<void> updateSectionOutput(String surfaceId, int sectionId, SurfaceTransform output);

  void changeInputTransform(String surfaceId, int sectionId, SurfaceTransform transform);
  void changeOutputTransform(String surfaceId, int sectionId, SurfaceTransform transform);
}

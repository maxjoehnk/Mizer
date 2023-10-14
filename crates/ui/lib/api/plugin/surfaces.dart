import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/surfaces.dart';
import 'package:mizer/protos/surfaces.pb.dart';

class SurfacesPluginApi implements SurfacesApi {
  final MethodChannel channel = const MethodChannel("mizer.live/surfaces");
  final EventChannel surfaceEvents = const EventChannel("mizer.live/surfaces/watch");

  @override
  Stream<List<Surface>> getSurfaces() {
    return surfaceEvents.receiveBroadcastStream().map((buffer) {
      return Surfaces.fromBuffer(_convertBuffer(buffer)).surfaces;
    });
  }

  @override
  Future<void> renameSurface(String surfaceId, String name) {
    // TODO: implement renameSurface
    throw UnimplementedError();
  }

  @override
  Future<void> updateSectionInput(String surfaceId, int sectionId, SurfaceTransform input) async {
    var sectionTransform = UpdateSectionTransform(
      surfaceId: surfaceId,
      sectionId: sectionId,
      transform: input,
    );
    await channel.invokeMethod("updateSectionInput", sectionTransform.writeToBuffer());
  }

  @override
  Future<void> updateSectionOutput(String surfaceId, int sectionId, SurfaceTransform output) async {
    var sectionTransform = UpdateSectionTransform(
      surfaceId: surfaceId,
      sectionId: sectionId,
      transform: output,
    );
    await channel.invokeMethod("updateSectionOutput", sectionTransform.writeToBuffer());
  }

  @override
  void changeInputTransform(String surfaceId, int sectionId, SurfaceTransform transform) {
    // TODO: implement changeInputTransform
  }

  @override
  void changeOutputTransform(String surfaceId, int sectionId, SurfaceTransform transform) {
    // TODO: implement changeOutputTransform
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }
}

import 'package:mizer/protos/layouts.pb.dart';

abstract class LayoutsApi {
  Future<Layouts> getLayouts();
  Future<Layouts> addLayout(String name);
  Future<Layouts> removeLayout(String id);
  Future<Layouts> renameLayout(String id, String name);

  Future<void> renameControl(String layoutId, String id, String name);
  Future<void> moveControl(String layoutId, String id, ControlPosition position);
  Future<void> deleteControl(String layoutId, String id);
}

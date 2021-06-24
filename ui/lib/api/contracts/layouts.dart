import 'package:mizer/protos/layouts.pb.dart';

abstract class LayoutsApi {
  Future<Layouts> getLayouts();
  Future<Layouts> addLayout(String name);
  Future<Layouts> removeLayout(String id);
  Future<Layouts> renameLayout(String id, String name);
}

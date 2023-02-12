import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../plugin/ffi/layout.dart';

abstract class LayoutsApi {
  Future<Layouts> getLayouts();
  Future<Layouts> addLayout(String name);
  Future<Layouts> removeLayout(String id);
  Future<Layouts> renameLayout(String id, String name);

  Future<void> addControl(String layoutId, Node_NodeType nodeType, ControlPosition position);
  Future<void> addControlForNode(String layoutId, String nodeId, ControlPosition position);
  Future<void> renameControl(String layoutId, String id, String name);
  Future<void> moveControl(String layoutId, String id, ControlPosition position);
  Future<void> updateControlDecoration(String layoutId, String id, ControlDecorations decoration);
  Future<void> updateControlBehavior(String layoutId, String id, ControlBehavior behavior);
  Future<void> deleteControl(String layoutId, String id);

  Future<double> readFaderValue(String nodeId);
  Future<LayoutsRefPointer?> getLayoutsPointer();
}

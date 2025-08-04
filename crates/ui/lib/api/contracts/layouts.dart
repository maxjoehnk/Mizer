import 'package:mizer/api/contracts/programmer.dart';
import 'package:mizer/protos/layouts.pb.dart';

import 'package:mizer/api/plugin/ffi/layout.dart';

abstract class LayoutsApi {
  Future<Layouts> getLayouts();
  Future<Layouts> addLayout(String name);
  Future<Layouts> removeLayout(String id);
  Future<Layouts> renameLayout(String id, String name);

  Future<void> addControl(String layoutId, ControlType controlType, ControlPosition position);
  Future<void> addControlForNode(String layoutId, String nodeId, ControlPosition position);
  Future<void> addControlForSequence(String layoutId, int sequenceId, ControlPosition position);
  Future<void> addControlForGroup(String layoutId, int groupId, ControlPosition position);
  Future<void> addControlForPreset(String layoutId, PresetId presetId, ControlPosition position);
  Future<void> renameControl(String layoutId, String id, String name);
  Future<void> moveControl(String layoutId, String id, ControlPosition position);
  Future<void> resizeControl(String layoutId, String id, ControlSize size);
  Future<void> updateControlDecoration(String layoutId, String id, ControlDecorations decoration);
  Future<void> updateControlBehavior(String layoutId, String id, ControlBehavior behavior);
  Future<void> deleteControl(String layoutId, String id);

  Future<double> readFaderValue(String nodeId);
  Future<LayoutsRefPointer?> getLayoutsPointer();
}

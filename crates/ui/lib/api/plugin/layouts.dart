import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pbenum.dart';

import 'ffi/api.dart';
import 'ffi/bindings.dart';
export 'ffi/layout.dart' show LayoutsRefPointer;

class LayoutsPluginApi implements LayoutsApi {
  final FFIBindings bindings;
  final MethodChannel channel = const MethodChannel("mizer.live/layouts");

  LayoutsPluginApi(this.bindings);

  @override
  Future<Layouts> getLayouts() async {
    var response = await channel.invokeMethod("getLayouts");

    return Layouts.fromBuffer(_convertBuffer(response));
  }

  static List<int> _convertBuffer(List<Object> response) {
    return response.map((dynamic e) => e as int).toList();
  }

  @override
  Future<Layouts> addLayout(String name) async {
    var response = await channel.invokeMethod("addLayout", name);

    return Layouts.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Layouts> removeLayout(String id) async {
    var response = await channel.invokeMethod("removeLayout", id);

    return Layouts.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<Layouts> renameLayout(String id, String name) async {
    var request = RenameLayoutRequest(id: id, name: name);
    var response = await channel.invokeMethod("renameLayout", request.writeToBuffer());

    return Layouts.fromBuffer(_convertBuffer(response));
  }

  @override
  Future<void> deleteControl(String layoutId, String id) async {
    var request = RemoveControlRequest(controlId: id, layoutId: layoutId);
    await channel.invokeMethod("removeControl", request.writeToBuffer());
  }

  @override
  Future<void> moveControl(String layoutId, String id, ControlPosition position) async {
    var request = MoveControlRequest(layoutId: layoutId, controlId: id, position: position);
    await channel.invokeMethod("moveControl", request.writeToBuffer());
  }

  @override
  Future<void> renameControl(String layoutId, String id, String name) async {
    var request = RenameControlRequest(layoutId: layoutId, controlId: id, name: name);
    await channel.invokeMethod("renameControl", request.writeToBuffer());
  }

  @override
  Future<void> addControl(String layoutId, Node_NodeType nodeType, ControlPosition position) async {
    var request = AddControlRequest(layoutId: layoutId, nodeType: nodeType, position: position);
    await channel.invokeMethod("addControl", request.writeToBuffer());
  }

  @override
  Future<void> addControlForNode(String layoutId, String nodeId, ControlPosition position) async {
    var request = AddExistingControlRequest(layoutId: layoutId, node: nodeId, position: position);
    await channel.invokeMethod("addExistingControl", request.writeToBuffer());
  }

  @override
  Future<void> updateControlDecoration(String layoutId, String id, ControlDecorations decoration) async {
    var request = UpdateControlDecorationRequest(layoutId: layoutId, controlId: id, decorations: decoration);
    await channel.invokeMethod("updateControlDecoration", request.writeToBuffer());
  }

  @override
  Future<void> updateControlBehavior(String layoutId, String id, ControlBehavior behavior) async {
    var request = UpdateControlBehaviorRequest(layoutId: layoutId, controlId: id, behavior: behavior);
    await channel.invokeMethod("updateControlBehavior", request.writeToBuffer());
  }

  @override
  Future<double> readFaderValue(String nodePath) async {
    var value = await channel.invokeMethod("readFaderValue", nodePath);

    return value as double;
  }

  @override
  Future<LayoutsRefPointer?> getLayoutsPointer() async {
    int pointer = await channel.invokeMethod("getLayoutsPointer");

    return this.bindings.openLayoutsRef(pointer);
  }
}

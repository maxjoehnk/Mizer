import 'package:mizer/api/contracts/layouts.dart';
import 'package:mizer/protos/layouts.pb.dart';
import 'package:mizer/protos/nodes.pbenum.dart';

class LayoutsDemoApi implements LayoutsApi {
  @override
  Future<Layouts> addLayout(String name) async {
    return Layouts();
  }

  @override
  Future<Layouts> getLayouts() async {
    return Layouts(layouts: [Layout(
      id: "Default"
    )]);
  }

  @override
  Future<Layouts> removeLayout(String id) async {
    return Layouts();
  }

  @override
  Future<Layouts> renameLayout(String id, String name) async {
    return Layouts();
  }

  @override
  Future<void> deleteControl(String layoutId, String id) {
    // TODO: implement deleteControl
    throw UnimplementedError();
  }

  @override
  Future<void> moveControl(String layoutId, String id, ControlPosition position) {
    // TODO: implement moveControl
    throw UnimplementedError();
  }

  @override
  Future<void> renameControl(String layoutId, String id, String name) {
    // TODO: implement renameControl
    throw UnimplementedError();
  }

  @override
  Future<void> addControl(String layoutId, Node_NodeType nodeType, ControlPosition position) {
    // TODO: implement addControl
    throw UnimplementedError();
  }

  @override
  Future<void> addControlForNode(String layoutId, String nodeId, ControlPosition position) {
    // TODO: implement addControlForNode
    throw UnimplementedError();
  }
}

import 'dart:developer';
import 'dart:ffi' as ffi;

import 'api.dart';
import 'bindings.dart';

class NodeHistoryPointer {
  final FFIBindings _bindings;
  final ffi.Pointer<NodeHistory> _ptr;

  NodeHistoryPointer(this._bindings, this._ptr);

  List<double> readHistory() {
    var result = this._bindings.read_node_history(_ptr);

    return result.toList();
  }

  void dispose() {
    log("TODO: dispose node history pointer");
    this._bindings.drop_node_history_pointer(_ptr);
  }
}

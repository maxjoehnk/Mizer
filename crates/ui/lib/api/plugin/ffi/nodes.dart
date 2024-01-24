import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:mizer/api/plugin/ffi/ffi_pointer.dart';

import 'bindings.dart';

class NodesPointer extends FFIPointer<NodesRef> {
  final FFIBindings _bindings;

  NodesPointer(this._bindings, ffi.Pointer<NodesRef> _ptr) : super(_ptr);

  List<NodePortMetadata> readPortMetadata() {
    var state = this._bindings.read_node_port_metadata(ptr);
    var metadata = new List.generate(state.len, (index) => state.array.elementAt(index).ref);

    return metadata.map((metadata) {
      return NodePortMetadata(metadata.node_path.cast<Utf8>().toDartString(),
          metadata.port_id.cast<Utf8>().toDartString(), metadata.pushed_value == 1);
    }).toList();
  }

  @override
  void disposePointer(ffi.Pointer<NodesRef> ptr) {
    this._bindings.drop_nodes_pointer(ptr);
  }
}

class NodePortMetadata {
  final String path;
  final String port;
  final bool pushedValue;

  NodePortMetadata(this.path, this.port, this.pushedValue);
}

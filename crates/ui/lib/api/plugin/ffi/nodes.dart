import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'bindings.dart';

class NodesPointer {
  final FFIBindings _bindings;
  final ffi.Pointer<NodesRef> _ptr;

  NodesPointer(this._bindings, this._ptr);

  List<NodePortMetadata> readPortMetadata() {
    var state = this._bindings.read_node_port_metadata(_ptr);
    var metadata = new List.generate(state.len, (index) => state.array.elementAt(index).ref);

    return metadata.map((metadata) {
      return NodePortMetadata(metadata.node_path.cast<Utf8>().toDartString(),
          metadata.port_id.cast<Utf8>().toDartString(), metadata.pushed_value == 1);
    }).toList();
  }

  void dispose() {
    this._bindings.drop_nodes_pointer(_ptr);
  }
}

class NodePortMetadata {
  final String path;
  final String port;
  final bool pushedValue;

  NodePortMetadata(this.path, this.port, this.pushedValue);
}

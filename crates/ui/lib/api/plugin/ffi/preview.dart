import 'dart:ffi' as ffi;

import 'transport.dart';
import 'bindings.dart';

class NodePreviewPointer implements TimecodeReader {
  final FFIBindings _bindings;
  final ffi.Pointer<NodePreview> _ptr;

  NodePreviewPointer(this._bindings, this._ptr);

  Timecode readTimecode() {
    var result = this._bindings.read_node_timecode(_ptr);

    return result;
  }

  void dispose() {
    this._bindings.drop_node_preview_pointer(_ptr);
  }
}

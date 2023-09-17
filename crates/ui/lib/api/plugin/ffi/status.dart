import 'dart:ffi' as ffi;

import 'bindings.dart';

class StatusPointer {
  final FFIBindings _bindings;
  final ffi.Pointer<StatusApi> _ptr;

  StatusPointer(this._bindings, this._ptr);

  double readFps() {
    var result = this._bindings.read_fps(_ptr);

    return result;
  }

  void dispose() {
    this._bindings.drop_status_pointer(_ptr);
  }
}

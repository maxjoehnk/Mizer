import 'dart:ffi' as ffi;

import 'bindings.dart';
import 'ffi_pointer.dart';

class StatusPointer extends FFIPointer<StatusApi> {
  final FFIBindings _bindings;

  StatusPointer(this._bindings, ffi.Pointer<StatusApi> ptr) : super(ptr);

  double readFps() {
    var result = this._bindings.read_fps(ptr);

    return result;
  }

  @override
  void disposePointer(ffi.Pointer<StatusApi> _ptr) {
    this._bindings.drop_status_pointer(_ptr);
  }
}

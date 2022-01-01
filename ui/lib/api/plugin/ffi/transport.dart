import 'dart:developer';
import 'dart:ffi' as ffi;

import 'bindings.dart';

class TransportPointer {
  final FFIBindings _bindings;
  final ffi.Pointer<Transport> _ptr;

  TransportPointer(this._bindings, this._ptr);

  Timecode readTimecode() {
    var result = this._bindings.read_timecode(_ptr);

    return result;
  }

  void dispose() {
    this._bindings.drop_transport_pointer(_ptr);
  }
}

import 'dart:ffi' as ffi;

import 'bindings.dart';

class TransportPointer implements TimecodeReader {
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

abstract class TimecodeReader {
  Timecode readTimecode();
  void dispose();
}

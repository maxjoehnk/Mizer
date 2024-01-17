import 'dart:ffi' as ffi;

import 'bindings.dart';
import 'ffi_pointer.dart';

class TransportPointer extends FFIPointer<Transport> implements TimecodeReader {
  final FFIBindings _bindings;

  TransportPointer(this._bindings, ffi.Pointer<Transport> ptr) : super(ptr);

  Timecode readTimecode() {
    var result = this._bindings.read_timecode(ptr);

    return result;
  }

  @override
  void disposePointer(ffi.Pointer<Transport> _ptr) {
    this._bindings.drop_transport_pointer(_ptr);
  }
}

abstract class TimecodeReader {
  Timecode readTimecode();
  void dispose();
}

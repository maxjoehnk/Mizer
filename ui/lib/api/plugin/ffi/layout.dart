import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'bindings.dart';

class LayoutsRefPointer {
  final FFIBindings _bindings;
  final ffi.Pointer<LayoutRef> _ptr;

  LayoutsRefPointer(this._bindings, this._ptr);

  double readFaderValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_fader_value(_ptr, ffiPath.cast<ffi.Char>());

    return result;
  }

  bool readButtonValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_button_value(_ptr, ffiPath.cast<ffi.Char>());

    return result == 1;
  }

  void dispose() {
    this._bindings.drop_layout_pointer(_ptr);
  }
}

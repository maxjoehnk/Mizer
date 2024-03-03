import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'bindings.dart';
import 'ffi_pointer.dart';

class LayoutsRefPointer extends FFIPointer<LayoutRef> {
  final FFIBindings _bindings;

  LayoutsRefPointer(this._bindings, ffi.Pointer<LayoutRef> ptr) : super(ptr);

  double readFaderValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_fader_value(ptr, ffiPath.cast<ffi.Char>());

    return result;
  }

  double readDialValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_dial_value(ptr, ffiPath.cast<ffi.Char>());

    return result;
  }

  bool readButtonValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_button_value(ptr, ffiPath.cast<ffi.Char>());

    return result == 1;
  }

  String readLabelValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_label_value(ptr, ffiPath.cast<ffi.Char>());

    return result.cast<Utf8>().toDartString();
  }

  @override
  void disposePointer(ffi.Pointer<LayoutRef> _ptr) {
    this._bindings.drop_layout_pointer(_ptr);
  }
}

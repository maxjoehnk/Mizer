import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:mizer/protos/layouts.pb.dart';

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

  Timecode readClockValue(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_clock_value(ptr, ffiPath.cast<ffi.Char>());

    return result;
  }

  Color? readControlColor(String path) {
    var ffiPath = path.toNativeUtf8();
    var result = this._bindings.read_control_color(ptr, ffiPath.cast<ffi.Char>());

    if (result.has_color == 0) {
      return null;
    }
    return Color(
      red: result.color_red,
      green: result.color_green,
      blue: result.color_blue,
    );
  }

  @override
  void disposePointer(ffi.Pointer<LayoutRef> _ptr) {
    this._bindings.drop_layout_pointer(_ptr);
  }
}

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:mizer/api/plugin/ffi/bindings.dart';
import 'package:mizer/api/plugin/ffi/ffi_pointer.dart';
import 'package:mizer/protos/layouts.pb.dart';

import 'api.dart';

class LayoutsRefPointer extends FFIPointer<LayoutRef> {
  final FFIBindings _bindings;

  LayoutsRefPointer(this._bindings, ffi.Pointer<LayoutRef> ptr) : super(ptr);

  double readFaderValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_fader_value(ptr, ffiPath.cast<ffi.Char>());

      return result;
    });
  }

  FFIDialValue readDialValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_dial_value(ptr, ffiPath.cast<ffi.Char>());

      return result;
    });
  }

  bool readButtonValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_button_value(ptr, ffiPath.cast<ffi.Char>());

      return result == 1;
    });
  }

  String readLabelValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_label_value(ptr, ffiPath.cast<ffi.Char>());

      return result.cast<Utf8>().toDartString();
    });
  }

  Timecode readClockValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_clock_value(ptr, ffiPath.cast<ffi.Char>());

      return result;
    });
  }

  Color? readControlColor(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_control_color(ptr, ffiPath.cast<ffi.Char>());

      if (result.has_color == 0) {
        return null;
      }
      return Color(
        red: result.color_red,
        green: result.color_green,
        blue: result.color_blue,
      );
    });
  }

  StepSequencerValue readStepSequencerValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      FFIStepSequencerValue result = this._bindings.read_step_sequencer_value(ptr, ffiPath.cast<ffi.Char>());

      var value = StepSequencerValue(result.value.asList().map((e) => e > 0).toList(), result.beat);

      this._bindings.drop_step_sequencer_value(result);

      return value;
    });
  }

  double readLevelValue(String path) {
    return using((arena) {
      var ffiPath = path.toNativeUtf8(allocator: arena);
      var result = this._bindings.read_level_value(ptr, ffiPath.cast<ffi.Char>());

      return result;
    });
  }

  @override
  void disposePointer(ffi.Pointer<LayoutRef> _ptr) {
    this._bindings.drop_layout_pointer(_ptr);
  }
}

class StepSequencerValue {
  final List<bool> values;
  final int beat;

  StepSequencerValue(this.values, this.beat);
}

import 'dart:ffi' as ffi;
import 'dart:io' as io;

import 'bindings.dart';
import 'connections.dart';
import 'history.dart';
import 'layout.dart';
import 'plans.dart';
import 'preview.dart';
import 'programmer.dart';
import 'sequencer.dart';
import 'transport.dart';

extension DoubleArray on Array_f64 {
  List<double> toList() {
    return array.asTypedList(len);
  }
}

FFIBindings openBindings() {
  final _dylibName = io.Platform.isMacOS
      ? 'libmizer_ui_ffi.dylib'
      : (io.Platform.isWindows ? 'mizer_ui_ffi.dll' : 'libmizer_ui_ffi.so');
  final dylib = ffi.DynamicLibrary.open(_dylibName);

  return FFIBindings(dylib);
}

extension FFIBindingsExt on FFIBindings {
  NodeHistoryPointer openNodeHistory(int pointerAddress) {
    var pointer = ffi.Pointer<NodeHistory>.fromAddress(pointerAddress);

    return NodeHistoryPointer(this, pointer);
  }

  NodePreviewPointer openNodePreview(int pointerAddress) {
    var pointer = ffi.Pointer<NodePreview>.fromAddress(pointerAddress);

    return NodePreviewPointer(this, pointer);
  }

  TransportPointer openTransport(int pointerAddress) {
    var pointer = ffi.Pointer<Transport>.fromAddress(pointerAddress);

    return TransportPointer(this, pointer);
  }

  SequencerPointer openSequencer(int pointerAddress) {
    var pointer = ffi.Pointer<Sequencer>.fromAddress(pointerAddress);

    return SequencerPointer(this, pointer);
  }

  ProgrammerStatePointer openProgrammer(int pointerAddress) {
    var pointer = ffi.Pointer<Programmer>.fromAddress(pointerAddress);

    return ProgrammerStatePointer(this, pointer);
  }

  FixturesRefPointer openFixturesRef(int pointerAddress) {
    var pointer = ffi.Pointer<FixturesRef>.fromAddress(pointerAddress);

    return FixturesRefPointer(this, pointer);
  }

  LayoutsRefPointer openLayoutsRef(int pointerAddress) {
    var pointer = ffi.Pointer<LayoutRef>.fromAddress(pointerAddress);

    return LayoutsRefPointer(this, pointer);
  }

  GamepadStatePointer openGamepadRef(int pointerAddress) {
    var pointer = ffi.Pointer<GamepadConnectionRef>.fromAddress(pointerAddress);

    return GamepadStatePointer(this, pointer);
  }
}

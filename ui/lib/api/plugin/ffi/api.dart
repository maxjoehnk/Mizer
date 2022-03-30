import 'dart:ffi' as ffi;
import 'dart:io' as io;

import 'programmer.dart';
import 'sequencer.dart';
import 'bindings.dart';
import 'transport.dart';
import 'history.dart';
import 'plans.dart';

extension DoubleArray on Array_f64 {
  List<double> toList() {
    return array.asTypedList(len);
  }
}

FFIBindings openBindings() {
  final _dylibName = io.Platform.isWindows ? 'mizer_ui_ffi.dll' : 'libmizer_ui_ffi.so';
  final dylib = io.Platform.isMacOS ? ffi.DynamicLibrary.executable() : ffi.DynamicLibrary.open(_dylibName);

  return FFIBindings(dylib);
}

extension FFIBindingsExt on FFIBindings {
  NodeHistoryPointer openNodeHistory(int pointerAddress) {
    var pointer = ffi.Pointer<NodeHistory>.fromAddress(pointerAddress);

    return NodeHistoryPointer(this, pointer);
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
}

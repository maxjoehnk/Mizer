import 'dart:ffi' as ffi;
import 'dart:io' show Directory;

import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:path/path.dart' as path;
import 'bindings.dart';
import 'transport.dart';
import 'history.dart';

extension DoubleArray on Array_f64 {
  List<double> toList() {
    return array.asTypedList(len);
  }
}

FFIBindings openBindings() {
  var libraryPath = path.join(Directory.current.path, 'target', 'debug', 'libmizer_ui_ffi.so');
  final dylib = ffi.DynamicLibrary.open(libraryPath);

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
}

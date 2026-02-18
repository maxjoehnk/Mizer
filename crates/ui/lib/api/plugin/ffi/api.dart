import 'dart:ffi' as ffi;
import 'dart:io' as io;

import 'package:mizer/api/plugin/ffi/status.dart';
import 'package:mizer/api/plugin/ffi/timecode.dart';

import 'package:mizer/api/plugin/ffi/bindings.dart';
import 'package:mizer/api/plugin/ffi/connections.dart';
import 'package:mizer/api/plugin/ffi/history.dart';
import 'package:mizer/api/plugin/ffi/layout.dart';
import 'package:mizer/api/plugin/ffi/nodes.dart';
import 'plans.dart';
import 'programmer.dart';
import 'package:mizer/api/plugin/ffi/sequencer.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';

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

  DevicesPointer openConnectionsRef(int pointerAddress) {
    var pointer = ffi.Pointer<ConnectionsRef>.fromAddress(pointerAddress);

    return DevicesPointer(this, pointer);
  }

  ConnectionsPointer openConnectionsViewRef(int pointerAddress) {
    var pointer = ffi.Pointer<ConnectionViewRef>.fromAddress(pointerAddress);

    return ConnectionsPointer(this, pointer);
  }

  NodesPointer openNodesRef(int pointerAddress) {
    var pointer = ffi.Pointer<NodesRef>.fromAddress(pointerAddress);

    return NodesPointer(this, pointer);
  }

  StatusPointer openStatus(int pointerAddress) {
    var pointer = ffi.Pointer<StatusApi>.fromAddress(pointerAddress);

    return StatusPointer(this, pointer);
  }

  TimecodePointer openTimecode(int pointerAddress) {
    var pointer = ffi.Pointer<TimecodeApi>.fromAddress(pointerAddress);

    return TimecodePointer(this, pointer);
  }
}

extension TimecodeExt on Timecode {
  double get totalSeconds {
    return hours * 3600 + minutes * 60 + seconds + (frames / 60);
  }
}

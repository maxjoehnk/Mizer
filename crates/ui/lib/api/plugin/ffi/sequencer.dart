import 'dart:ffi' as ffi;

import 'package:flutter/foundation.dart';
import 'package:mizer/api/plugin/ffi/ffi_pointer.dart';

import 'package:mizer/api/plugin/ffi/bindings.dart' as bindings;

class SequencerPointer extends FFIPointer<bindings.Sequencer> {
  final bindings.FFIBindings _bindings;

  SequencerPointer(this._bindings, ffi.Pointer<bindings.Sequencer> ptr) : super(ptr);

  Map<int, SequenceState> readState() {
    bindings.Array_SequenceState result = this._bindings.read_sequencer_state(ptr);

    var states = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    return states
        .asMap()
        .map((key, value) => MapEntry(value.sequence_id, SequenceState.fromBinding(value)));
  }

  @override
  void disposePointer(ffi.Pointer<bindings.Sequencer> _ptr) {
    this._bindings.drop_sequencer_pointer(_ptr);
  }
}

class SequenceState with Diagnosticable {
  bool active;
  int? cueId;
  double rate;

  SequenceState({required this.active, required this.cueId, required this.rate});
  factory SequenceState.fromBinding(bindings.SequenceState binding) {
    return SequenceState(
        active: binding.active == 1,
        cueId: binding.current_cue_id == 0 ? null : binding.current_cue_id,
        rate: binding.rate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty("active", active));
    properties.add(DiagnosticsProperty("cueId", cueId));
    properties.add(DiagnosticsProperty("rate", rate));
  }
}

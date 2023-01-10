import 'dart:developer';
import 'dart:ffi' as ffi;

import 'package:flutter/foundation.dart';

import 'bindings.dart' as bindings;

class SequencerPointer {
  final bindings.FFIBindings _bindings;
  final ffi.Pointer<bindings.Sequencer> _ptr;

  SequencerPointer(this._bindings, this._ptr);

  Map<int, SequenceState> readState() {
    bindings.Array_SequenceState result = this._bindings.read_sequencer_state(_ptr);

    var states = new List.generate(result.len, (index) => result.array.elementAt(index).ref);

    return states.asMap().map((key, value) => MapEntry(value.sequence_id, SequenceState.fromBinding(value)));
  }

  void dispose() {
    log("TODO: dispose programmer pointer");
    this._bindings.drop_sequencer_pointer(_ptr);
  }
}

class SequenceState with Diagnosticable {
    bool active;
    int? cueId;
    double rate;

    SequenceState({ required this.active, required this.cueId, required this.rate });
    factory SequenceState.fromBinding(bindings.SequenceState binding) {
      return SequenceState(active: binding.active == 1, cueId: binding.current_cue_id == 0 ? null : binding.current_cue_id, rate: binding.rate);
    }

    @override
    void debugFillProperties(DiagnosticPropertiesBuilder properties) {
      super.debugFillProperties(properties);
      properties.add(DiagnosticsProperty("active", active));
      properties.add(DiagnosticsProperty("cueId", cueId));
      properties.add(DiagnosticsProperty("rate", rate));
    }
}


import 'dart:ffi' as ffi;

import 'bindings.dart';
import 'ffi_pointer.dart';
import 'transport.dart';

class TimecodePointer extends FFIPointer<TimecodeApi> {
  final FFIBindings _bindings;

  TimecodePointer(this._bindings, ffi.Pointer<TimecodeApi> ptr) : super(ptr);

  TimecodeTrackReader getTrackReader(int timecodeId) {
    return TimecodeTrackReader(this, timecodeId);
  }

  Timecode _readTimecode(int timecodeId) {
    var result = this._bindings.read_timecode_clock(ptr, timecodeId);

    return result;
  }

  @override
  void disposePointer(ffi.Pointer<TimecodeApi> _ptr) {
    this._bindings.drop_timecode_pointer(_ptr);
  }
}

class TimecodeTrackReader implements TimecodeReader {
  final TimecodePointer _pointer;
  final int _timecodeId;

  TimecodeTrackReader(this._pointer, this._timecodeId);

  @override
  void dispose() {}

  @override
  Timecode readTimecode() {
    var result = this._pointer._readTimecode(this._timecodeId);

    return result;
  }
}

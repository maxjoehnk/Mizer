import 'dart:ffi' as ffi;

abstract class FFIPointer<TPtr extends ffi.NativeType> {
  final ffi.Pointer<TPtr> _ptr;
  bool _disposed = false;

  FFIPointer(this._ptr);

  void dispose() {
    if (_disposed) {
      return;
    }
    this.disposePointer(_ptr);
    this._disposed = true;
  }

  void disposePointer(ffi.Pointer<TPtr> _ptr);

  ffi.Pointer<TPtr> get ptr {
    if (_disposed) {
      throw new Exception("Pointer is already disposed");
    }

    return _ptr;
  }

  bool get isDisposed => _disposed;
}

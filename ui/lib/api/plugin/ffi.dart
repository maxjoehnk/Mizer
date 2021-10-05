import 'dart:developer';
import 'dart:ffi' as ffi;
import 'dart:io' show Directory;

import 'package:path/path.dart' as path;

typedef read_doubles_func = DoubleArray Function(ffi.Uint64);
typedef drop_pointer_func = ffi.Void Function(ffi.Uint64);

class ByteArray extends ffi.Struct {
  @ffi.Uint32()
  external int len;

  external ffi.Pointer<ffi.Uint8> array;

  List<int> toList() {
    return array.asTypedList(len);
  }
}

class DoubleArray extends ffi.Struct {
  @ffi.Uint32()
  external int len;

  external ffi.Pointer<ffi.Double> array;

  List<double> toList() {
    return array.asTypedList(len);
  }
}

typedef ReadDoubleArray = DoubleArray Function(int);
typedef DropPointer = void Function(int);

var libraryPath = path.join(Directory.current.path, 'target', 'debug', 'libmizer_ui_ffi.so');

final dylib = ffi.DynamicLibrary.open(libraryPath);

final ReadDoubleArray readNodeHistoryFunc =
    dylib.lookup<ffi.NativeFunction<read_doubles_func>>('read_node_history').asFunction();

final DropPointer dropPointerFunc =
    dylib.lookup<ffi.NativeFunction<drop_pointer_func>>('drop_pointer').asFunction();

class NodeHistoryPointer {
  final int _ptr;

  NodeHistoryPointer(this._ptr);

  List<double> readHistory() {
    var result = readNodeHistoryFunc(_ptr);

    return result.toList();
  }

  void dispose() {
    log("TODO: dispose node history pointer");
    dropPointerFunc(_ptr);
  }
}

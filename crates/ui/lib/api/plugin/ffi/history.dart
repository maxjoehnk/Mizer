import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:mizer/api/plugin/ffi/transport.dart';
import 'package:mizer/widgets/inputs/color.dart';

import 'api.dart';
import 'bindings.dart';
import 'ffi_pointer.dart';

class NodeHistoryPointer extends FFIPointer<NodeHistory> implements TimecodeReader {
  final FFIBindings _bindings;

  NodeHistoryPointer(this._bindings, ffi.Pointer<NodeHistory> _ptr) : super(_ptr);

  List<double> readHistory() {
    var result = this._bindings.read_node_history(ptr);

    return result.toList();
  }

  StructuredData readData() {
    var result = this._bindings.read_node_data_preview(ptr);

    return _convertData(result);
  }

  StructuredData _convertData(FFIStructuredData data) {
    if (data.type == FFIStructuredDataType.Text) {
      return StructuredData(text: data.value.text.cast<Utf8>().toDartString());
    }
    if (data.type == FFIStructuredDataType.Float) {
      return StructuredData(float: data.value.floating_point);
    }
    if (data.type == FFIStructuredDataType.Int) {
      return StructuredData(integer: data.value.integer);
    }
    if (data.type == FFIStructuredDataType.Boolean) {
      return StructuredData(boolean: data.value.boolean == 1);
    }
    if (data.type == FFIStructuredDataType.Array) {
      var array = new List.generate(
              data.value.array.len, (index) => data.value.array.array.elementAt(index).ref)
          .map((e) => _convertData(e))
          .toList();
      return StructuredData(array: array);
    }
    if (data.type == FFIStructuredDataType.Object) {
      var mapEntries = new List.generate(
              data.value.object.len, (index) => data.value.object.array.elementAt(index).ref)
          .map((e) => MapEntry(e.key.cast<Utf8>().toDartString(), _convertData(e.value)));
      var object = Map.fromEntries(mapEntries);

      return StructuredData(object: object);
    }
    throw new Exception("Invalid FFI StructuredDataType: ${data.type}");
  }

  ColorValue? readColor() {
    var result = this._bindings.read_node_color_preview(ptr);

    return ColorValue(red: result.red, green: result.green, blue: result.blue);
  }

  Timecode readTimecode() {
    var result = this._bindings.read_node_timecode_preview(ptr);

    return result;
  }

  List<double> readMulti() {
    var result = this._bindings.read_node_multi_preview(ptr);

    return result.toList();
  }

  @override
  void disposePointer(ffi.Pointer<NodeHistory> ptr) {
    this._bindings.drop_node_history_pointer(ptr);
  }
}

class StructuredData {
  final String? text;
  final double? float;
  final int? integer;
  final bool? boolean;
  final List<StructuredData>? array;
  final Map<String, StructuredData>? object;

  StructuredData({this.float, this.integer, this.boolean, this.text, this.object, this.array});

  @override
  String toString() {
    return 'StructuredData{text: $text, float: $float, integer: $integer, boolean: $boolean, array: $array, object: $object}';
  }
}
